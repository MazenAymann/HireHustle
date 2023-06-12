import os
import csv
import pandas as pd
import time
from datetime import datetime
from Applicant import Applicant
from HR_Recruiter import HrRecruiter
from CV_Extraction import extract_cv_info
from Interview_Scheduling import schedule_interview
from linkedin_api import Linkedin
from Score_Calculation import applicant_clustering
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler

if __name__ == "__main__":
    # Store HR Recruiter name and available slots for interview
    available_slots = [
        {
            'start_time': datetime(2022, 5, 2, 9, 0, 0),
            'end_time': datetime(2022, 5, 2, 10, 0, 0)
        },
        {
            'start_time': datetime(2022, 5, 2, 10, 0, 0),
            'end_time': datetime(2022, 5, 2, 11, 0, 0)
        },
        {
            'start_time': datetime(2022, 5, 2, 11, 0, 0),
            'end_time': datetime(2022, 5, 2, 12, 0, 0)
        },
        # Add more available time slots as needed
    ]
    recruiter = HrRecruiter("Messi", available_slots)

    # Define the path to the directory containing the CV PDF files
    dir_path = 'C:/Users/Mazin/PycharmProjects/gp/dataset'

    # Login to LinkedIN api with try-except in case of login errors
    while True:
        # noinspection PyBroadException
        try:
            email = "mazenaymanmo22@gmail.com"
            password = "Mezomane123123"
            linkedin_api = Linkedin(email, password)
            print("Login Successfully")
            break
        except Exception as e:
            print(e)

    # Create a list to store the CV information
    cv_info_list = []

    # Iterate over all the PDF files in the directory and extract the information
    for file_name in os.listdir(dir_path):
        if file_name.endswith('.pdf'):
            file_path = os.path.join(dir_path, file_name)
            cv_info = extract_cv_info(file_path, linkedin_api)
            cv_info_list.append(cv_info)

    # Convert the list of dictionaries to a Pandas DataFrame
    df = pd.DataFrame(cv_info_list)

    # Create a list to store an applicant objects
    applicant_list = []

    for applicant in cv_info_list:
        applicantObject = Applicant(
            applicant.get('Name'),
            applicant.get('Email'),
            applicant.get('Phone'),
            applicant.get('LinkedIN Profile'),
            applicant.get('GitHub Profile'),
            applicant.get('Public GitHub Repos Name & Commits'),
            applicant.get('Industry Name'),
            applicant.get('Certificates'),
            applicant.get('Experience'),
            applicant.get('Education'),
            applicant.get('Programming Languages'),
            applicant.get('Spoken Languages'),
        )
        # Put all applicants objects in the list
        applicant_list.append(applicantObject)

    # add the cluster_label column to the dataframe
    df['Technical Cluster'] = applicant_clustering(applicant_list)

    # save the updated dataframe to a new CSV file
    df.to_csv('cv_info.csv', index=False)

    # Sending a confirmation email
    for index, applicant in enumerate(applicant_list, start=1):
        print(f"{index}- {applicant.name}")

    val = int(input("Please choose an applicant for the jop: "))
    schedule_interview(applicant_list[val - 1], recruiter)

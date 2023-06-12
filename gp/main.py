import os
import csv
import pandas as pd
import time
from datetime import datetime
from Applicant import Applicant
from HR_Recruiter import HrRecruiter
from cv_extraction import extract_cv_info
from interview_scheduling import schedule_interview
from linkedin_api import Linkedin
from cluster import get_technical_cluster, get_cv_cluster
from similarity import calc_similarity
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
    dir_path = 'C:/Users/Mazin/PycharmProjects/gp/CVs_PDF/'

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

        # add the similarity column to the dataframe
    df['Similarity'] = calc_similarity(
        'Job_description_PDF/',
        'Job_description_TXT/',
        'CVs_PDF/',
        'CVs_TXT/'
    )

    # add the cluster_label column to the dataframe
    df['CV Cluster'] = get_cv_cluster('CVs_TXT')

    # add the cluster_label column to the dataframe
    df['Technical Cluster'] = get_technical_cluster(applicant_list)

    # save the updated dataframe to a new CSV file and save it to cv infos folder
    folder_name = 'cv infos'
    if not os.path.exists(folder_name):
        os.makedirs(folder_name)

    cv_info = os.path.join(folder_name, 'cv_info.csv')
    df.to_csv(cv_info, index=False)

    # Sending a confirmation email
    for index, applicant in enumerate(applicant_list, start=1):
        print(f"{index}- {applicant.email}")

    val = int(input("Please choose an applicant for the jop: "))
    schedule_interview(applicant_list[val - 1], recruiter)

import random
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from flask import Blueprint, request, jsonify
from datetime import datetime
import yagmail


my_send_confirmation_email = Blueprint('my_send_confirmation_email', __name__)

# Replace these values with your own email and password
email = 'hire.hustle1@gmail.com'
password = 'ipozfcndqykqpslz'


def json_to_dictionary(data):
    my_dict = {}  # create an empty dictionary
    for key, value in data.items():
        my_dict[key] = value

    return my_dict


def send_confirmation_email(applicant_name, applicant_email, interview_time):
    # Convert interview_time string to datetime object
    datetime_obj = datetime.strptime(interview_time, '%Y-%m-%d %H:%M:%S.%f')

    # Create the desired format
    new_interview_time_format = datetime_obj.strftime('day %d-%m-%Y at %H:%M')

    subject = 'Interview Scheduled'
    body = f'Dear {applicant_name},\n\nYour interview has been scheduled for {new_interview_time_format}.' \
           f'\n\nThank you,\nHireHustle Team'

    # msg = MIMEMultipart()
    # msg['From'] = 'Hire Hustle <hire.hustle1@gmail.com>'
    # msg['To'] = applicant_email
    # msg['Subject'] = subject
    #
    # msg.attach(MIMEText(body, 'plain'))
    #
    # # Send the email
    # server = smtplib.SMTP('smtp.gmail.com', 587)
    # server.starttls()
    # server.login(email, password)
    # text = msg.as_string()
    # server.sendmail(email, msg['To'], text)
    # server.quit()

    # Create a yagmail object
    yag = yagmail.SMTP(email, password)

    yag.send(to=applicant_email, subject=subject, contents=body)

    return new_interview_time_format


@my_send_confirmation_email.route("/send-confirmation", methods=["POST"])
def schedule_interview():
    json = request.get_json()

    if json is None or json == "":
        return jsonify({"error": "No input provided"})

    # Change JSON to dictionary
    dictonary = json_to_dictionary(json)
    print(dictonary)

    applicant_name = dictonary['applicant_name']
    applicant_email = dictonary['applicant_email']
    available_slots = dictonary['available_slots']

    if not available_slots:
        print("There is no available slots.")
        return jsonify({"error": "No available slots"})  # No available slots left

    selected_slot = random.choice(available_slots)
    available_slots.remove(selected_slot)

    while True:
        try:
            interview_time = send_confirmation_email(applicant_name, applicant_email, selected_slot)
            print("Confirmation email is sent successfully.")
            break
        except Exception as e:
            print(e)

    return jsonify({"interview_time": str(interview_time)})
import random
import schedule
import time
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email import encoders

# Replace these values with your own email and password
email = 'hire.hustle1@gmail.com'
password = 'ipozfcndqykqpslz'


def send_confirmation_email(applicant, interview_time):
    subject = 'Interview Scheduled'
    body = f'Dear {applicant.name},\n\nYour interview has been scheduled for {interview_time}.' \
           f'\n\nThank you,\nHireHustle Team'

    msg = MIMEMultipart()
    msg['From'] = 'Hire Hustle <hire.hustle1@gmail.com>'
    msg['To'] = applicant.email
    msg['Subject'] = subject

    msg.attach(MIMEText(body, 'plain'))

    # Send the email
    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login(email, password)
    text = msg.as_string()
    server.sendmail(email, msg['To'], text)
    server.quit()


def schedule_interview(applicant, hr_recruiter):
    if not hr_recruiter.available_slots:
        print("There is no available slots.")
        return None  # No available slots left

    selected_slot = random.choice(hr_recruiter.available_slots)
    hr_recruiter.available_slots.remove(selected_slot)

    # Schedule the interview using the selected time slot
    interview_time = selected_slot['start_time']

    # Do something with the interview time (e.g., send a confirmation email)
    # noinspection PyBroadException
    try:
        send_confirmation_email(applicant, interview_time)
        print("Confirmation email is sent successfully.")
    except:
        print("There is an error in sending the email.")

    return interview_time

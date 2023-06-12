import re
import fitz
import requests
import spacy
from github import Github
import datetime

# Load the English language model in spaCy
nlp = spacy.load('en_core_web_sm')
# Define patterns for email, phone number, LinkedIN and GitHub extraction
email_pattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'
phone_pattern = r'((\+?2)?01\d{9}|02\d{7})'
linkedin_pattern = r'(?:http[s]?://)?(?:[a-z]+\.)?linkedin\.com/(?:in|pub|profile)/[a-zA-Z0-9_-]+/?'
github_pattern = r'(?:https?://)?(?:www\.)?github\.com/[a-zA-Z0-9_-]+/?'

# Set the personal access token for GitHub
github_access_token = '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'

# Set the request headers to include the token
headers = {'Authorization': f'token {github_access_token}'}


def get_github_username(profile_link):
    # Define the regular expression pattern to match the username
    pattern = r'github\.com/([^/]+)'

    # Match the username using the regular expression pattern
    match = re.search(pattern, profile_link)

    # Check if a match was found
    if match:
        # Get the username from the match object
        return match.group(1)


def get_linkedin_username(profile_link):
    # Use regular expression to extract the username
    pattern = re.compile(r"/in/([a-z0-9\-]+)/?$")
    match = re.search(pattern, profile_link)
    # Check if a match was found
    if match:
        # Get the username from the match object
        return match.group(1)


def get_commits_num(username):
    # Create a GET request to the GitHub REST API to retrieve the user's repos
    repos_url = f'https://api.github.com/users/{username}/repos'
    response = requests.get(repos_url, headers=headers)

    # Extract the list of repositories from the response
    repos = response.json()

    # Loop through each repository and count the total number of commits
    commit_count = 0
    for repo in repos:
        # Create a GET request to the GitHub REST API to retrieve the commits for this repository
        commits_url = repo['commits_url'].replace('{/sha}', '')
        response = requests.get(commits_url)

        # Extract the list of commits from the response and add the count to the total
        commits = response.json()
        commit_count += len(commits)

    return commit_count


def get_repos_name_commit(username):
    # create a GitHub instance
    g = Github(github_access_token)

    # replace USERNAME with the username of the user whose repositories you want to access
    user = g.get_user(username)

    # get a list of the user's repositories
    repos = user.get_repos()

    # get the names of the user's repositories
    reposNamesCommits = []
    for repo in repos:
        commits = list(repo.get_commits())
        num_commits = len(commits)
        repoInfo = [repo.name, num_commits]
        reposNamesCommits.append(repoInfo)
    return reposNamesCommits


def get_prog_lang(username):
    # Replace with your own GitHub username or organization name
    github_username = username

    # Define the GitHub API URL for the user or organization's repositories
    repos_url = f"https://api.github.com/users/{github_username}/repos"

    # Define a dictionary to store the language data for each repository
    languages = {}

    # Send a GET request to the repos URL using the requests library
    response = requests.get(repos_url, headers=headers)

    # Iterate through the response data and retrieve the language information for each repository
    for repo in response.json():
        repo_name = repo["name"]
        languages_url = f"https://api.github.com/repos/{github_username}/{repo_name}/languages"
        languages_data = requests.get(languages_url, headers=headers).json()
        for language, bytes_of_code in languages_data.items():
            if language in languages:
                languages[language] += bytes_of_code
            else:
                languages[language] = bytes_of_code

    return languages


def get_linkedin_info(username, api):
    # Get the profile information
    profile = api.get_profile(username)

    # Get the data
    clientName = []
    clientIndustryName = []
    clientCertificates = []
    clientExperience = []
    clientEducation = []

    # Get first name and the last name of the client
    if 'firstName' in profile and 'lastName' in profile:
        first_name = profile['firstName']
        last_name = profile['lastName']
        clientName.append(f"{first_name} {last_name}")
    else:
        clientName.append("N/A")

    # Get industry name of the client
    if 'industryName' in profile:
        industryName = profile['industryName']
        clientIndustryName.append(industryName)
    else:
        clientIndustryName.append("N/A")

    # Get the skills of the client
    if "certifications" in profile:
        clientCertificates = [f"{certificate['authority']} - {certificate['name']}" for certificate in profile["certifications"]]
    else:
        clientCertificates.append("N/A")

    # Get the exp of the client
    if "experience" in profile:

        for experience in profile["experience"]:
            # Retrieve start and end dates
            start_date = experience['timePeriod']['startDate']['year']
            end_date = experience['timePeriod']['endDate'][
                'year'] if 'endDate' in experience else datetime.datetime.now().year

            # Calculate duration in years
            duration = end_date - start_date

            exp = [experience["companyName"], experience["title"], duration]
            clientExperience.append(
                exp
            )
    else:
        clientExperience.append("N/A")

    # Get the education of the client
    if "education" in profile:
        clientEducation = [education["schoolName"] for education in profile["education"]]
    else:
        clientEducation.append("N/A")

    linkedinInfo = [clientName, clientIndustryName, clientCertificates, clientExperience, clientEducation]
    return linkedinInfo


def extract_cv_info(path, linkedin_api):
    # Read the PDF file
    with fitz.open(path) as doc:
        text = ""
        for page in doc:
            text += page.get_text()

    # Finding email, phone, LinkedIN profile and GitHub profile using patterns
    email = re.findall(email_pattern, text)
    phone = re.findall(phone_pattern, text)
    linkedin_profile = re.findall(linkedin_pattern, text)
    github_profile = re.findall(github_pattern, text)

    # Handle if the CV does not contain GitHub account
    if github_profile:
        github_username = get_github_username(github_profile[0])
        name_of_repos_commits = get_repos_name_commit(github_username)
        programming_languages = get_prog_lang(github_username)
    else:
        github_profile = ['N/A']
        name_of_repos_commits = 'N/A'
        programming_languages = ['N/A']

    # Handle if the CV does not contain LinkedIN account
    if linkedin_profile:
        username = get_linkedin_username(linkedin_profile[0])
        linkedin_info = get_linkedin_info(username, linkedin_api)
    else:
        linkedin_profile = ['N/A']
        linkedin_info = [['N/A'], ['N/A'], ['N/A'], ['N/A'], ['N/A']]

    # Handle if the CV does not contain email
    if not email:
        email = ['N/A']

    # Handle if the CV does not contain phone number
    if phone:
        phone = [number[0] for number in phone]
    else:
        phone = ['N/A']

    # Use spaCy to process the text and perform named entity recognition
    doc = nlp(text)
    # print(doc)

    # Extract the certificates and skills
    cert_labels = ['CERTIFICATES', 'LICENSE', 'DEGREE']
    skill_labels = ['SKILLS', 'EXPERTISE', 'KNOWLEDGE']
    language_label = ['LANGUAGE']

    # Extracts certificates, skills and languages from a CV PDF file
    certificates = []
    skills = []
    languages = []

    # Change the label of "English" and "Arabic" from "NORP" to "LANGUAGE" by updating the entity label
    for ent in doc:
        if ent.text == "English" or ent.text == "Arabic":
            ent.ent_type_ = "LANGUAGE"

    # Labeling each entity in the CV
    for ent in doc.ents:
        if ent.label_ in cert_labels:
            certificates.append(ent.text)
        elif ent.label_ in skill_labels:
            skills.append(ent.text)
        elif ent.label_ in language_label:
            languages.append(ent.text)

    # Remove duplicates from the languages
    languages = list(set(languages))

    # Create a dictionary to store the data
    data = {'Name': linkedin_info[0][0], 'Email': email[0], 'Phone': phone[0],
            'LinkedIN Profile': linkedin_profile[0],
            'GitHub Profile': github_profile[0], 'Public GitHub Repos Name & Commits': name_of_repos_commits,
            'Industry Name': linkedin_info[1], 'Certificates': linkedin_info[2], 'Experience': linkedin_info[3],
            'Education': linkedin_info[4], 'Programming Languages': programming_languages, 'Spoken Languages': languages}

    return data

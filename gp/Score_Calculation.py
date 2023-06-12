from Applicant import Applicant
import numpy as np
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler

# Set the weights for each factor
technical_weight = 0.3
experience_weight = 0.2
industry_weight = 0.1
communication_weight = 0.1


def calculate_score(applicant):
    # Calculate the score for technical skills
    numCommits = 0
    for Repo in applicant.github_repos_commits:
        numCommits += Repo[1]

    technical_score = len(applicant.github_repos_commits) + numCommits + len(
        applicant.programming_languages)

    # Calculate the score for experience
    experience_score = len(applicant.experience)

    # Calculate the score for education
    industry_score = 0
    desiredIndustry = ["Computer Science", "Information Technology & Services", "IT Services and IT Consulting"]
    for industry in desiredIndustry:
        if applicant.industry_name == industry:
            industry_score = 1

    # Calculate the score for communication skills
    communication_score = len(applicant.languages)

    # Calculate the total score
    total_score = (technical_score * technical_weight) + (experience_score * experience_weight) + \
                  (industry_score * industry_weight) + (communication_score * communication_weight)

    applicant.score = total_score


def get_repo_name(applicant, repo_name=None):
    numRepos = 0
    if repo_name is not None:
        for Repo in applicant.github_repos_commits:
            if Repo[0].__contains__(repo_name):
                numRepos += 1
        return numRepos
    else:
        return len(applicant.github_repos_commits)


def get_commits_num(applicant, repo_name=None):
    numCommits = 0
    if repo_name is not None:
        for Repo in applicant.github_repos_commits:
            if Repo[0].__contains__(repo_name):
                numCommits += Repo[1]
        return numCommits
    else:
        for Repo in applicant.github_repos_commits:
            numCommits += Repo[1]
        return numCommits


def check_industry_name(applicant, desired_industry):
    industry_score = 0
    for industry in desired_industry:
        if applicant.industry_name[0] == industry:
            industry_score = 1
    return industry_score


def get_certificates(applicant, certifi_name=None):
    numCertifi = 0
    if certifi_name is not None:
        for certifi in applicant.certificates:
            if certifi.__contains__(certifi_name):
                numCertifi += 1
        return numCertifi
    else:
        for certifi in applicant.certificates:
            numCertifi += 1
        return numCertifi


def get_exp_years(applicant, company=None, position=None):
    # noinspection PyBroadException
    try:
        # If the company and position are given
        if company is not None and position is not None:
            for exp in applicant.experience:
                if company == exp[0] and position == exp[1]:
                    return exp[2]

        # If the company is given
        elif company is not None and position is None:
            for exp in applicant.experience:
                if company == exp[0]:
                    return exp[2]

        # If the position is given
        elif company is None and position is not None:
            for exp in applicant.experience:
                if position == exp[1]:
                    return exp[2]

        # If the company and position are not given
        elif company is None and position is None:
            years = 0
            for exp in applicant.experience:
                years += exp[2]
            return years
    except:
        return 0


def get_programming_languages_lines(applicant, prog_lang=None):
    # noinspection PyBroadException
    try:
        if prog_lang is not None:
            if prog_lang in applicant.programming_languages.keys():
                return applicant.programming_languages[prog_lang]
            else:
                return 0
        else:
            lines = 0
            for numLines in applicant.programming_languages.values():
                lines += numLines
            return lines
    except:
        return 0


def get_spoken_languages(applicant, lang=None):
    if lang is not lang:
        if lang in applicant.languages:
            return 1
        else:
            return 0
    else:
        return len(applicant.languages)


# define a function to extract features from each applicant object
def extract_features(applicant):
    repos = len(applicant.github_repos_commits)
    industry = len(applicant.industry_name)
    certs = get_certificates(applicant)
    exp_years = get_exp_years(applicant)
    edu_level = len(applicant.education)
    prog_langs = get_programming_languages_lines(applicant)
    spoken_langs = len(applicant.languages)

    # convert features to a numerical vector
    features = [repos, industry, certs, exp_years, edu_level, prog_langs, spoken_langs]
    feature_vec = []
    for feature in features:
        if isinstance(feature, list):
            feature_vec.extend(feature)
        else:
            feature_vec.append(feature)
    return feature_vec


def applicant_clustering(applicant_list):
    # extract features from each applicant object
    X = [extract_features(applicant) for applicant in applicant_list]

    # standardize the feature values to have zero mean and unit variance
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)

    # apply K-means clustering to group applicants into clusters
    kmeans = KMeans(n_clusters=3, random_state=0, n_init=20)
    kmeans.fit(X_scaled)
    cluster_labels = kmeans.predict(X_scaled)

    # Give each applicant his cluster
    for i, applicant in enumerate(applicant_list):
        applicant.cluster = cluster_labels[i]

    return cluster_labels

import os
from Applicant import Applicant
import numpy as np
from sklearn.cluster import KMeans
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.preprocessing import StandardScaler
from technical_filter import get_certificates, get_exp_years, get_programming_languages_lines


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


def get_technical_cluster(applicant_list):
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


# define function to read text from file
def read_text_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        text = f.read()
    return text


def get_cv_cluster(folder_path):
    # create a list of file paths in the folder
    file_names = os.listdir(folder_path)
    file_paths = [os.path.join(folder_path, file_name) for file_name in file_names if file_name.endswith('.txt')]

    # read text from files
    docs = [read_text_file(file_path) for file_path in file_paths]

    # vectorize the text using TfidfVectorizer
    vectorizer = TfidfVectorizer(stop_words='english')
    X = vectorizer.fit_transform(docs)

    # perform KMeans clustering
    n_clusters = 3
    kmeans = KMeans(n_clusters=n_clusters, random_state=0, n_init=20)
    cluster_labels = kmeans.fit_predict(X)

    return cluster_labels

class Applicant:
    def __init__(self, name, email, phone, linkedin_profile,
                 github_profile, github_repos_commits, industry_name,
                 certificates, experience, education, programming_languages,
                 languages):
        self.name = name
        self.email = email
        self.phone = phone
        self.linkedin_profile = linkedin_profile
        self.github_profile = github_profile
        self.github_repos_commits = github_repos_commits
        self.industry_name = industry_name
        self.certificates = certificates
        self.experience = experience
        self.education = education
        self.programming_languages = programming_languages
        self.languages = languages
        self.score = None
        self.cluster = None

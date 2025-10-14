# Project-1


# 🚀 Flask Application CI/CD using Jenkins and Docker

## 📘 Project Overview
This project demonstrates how to automate the build and deployment of a simple Python Flask web application using **Jenkins Pipeline** and **Docker**.

The goal is to:
- Clone source code from GitHub  
- Build a Docker image for the Flask app  
- Run the application inside a Docker container  
- Access it through a public EC2 IP

---

## 🏗️ Tech Stack
- **Language:** Python 3
- **Framework:** Flask
- **Base Image:** Amazon Linux
- **Automation Tool:** Jenkins
- **Containerization:** Docker
- **Platform:** AWS EC2

---

## 🧩 Project Structure

```

Project-1/
├── app.py           # Flask web application
├── Dockerfile       # Docker image build instructions
└── Jenkinsfile      # Jenkins pipeline script

````

---

## ⚙️ Jenkins Pipeline (Jenkinsfile)

```groovy
pipeline {
    agent any

    stages {
        stage('cloning') {
            steps {
                echo 'cloning the code'
                git branch: 'main', url: 'https://github.com/Sk-Nagul-09/Project-1.git'
            }
        }
        
        stage('docker image') {
            steps {
                echo 'creating docker image'
                sh 'docker build -t basic_img:${BUILD_NUMBER} .'
            }
        }
        
        stage('docker run') {
            steps {
                echo 'Running the container'
                sh 'docker stop cont_${BUILD_NUMBER} || true'
                sh 'docker rm cont_${BUILD_NUMBER} || true'
                sh 'docker run -d --name cont_${BUILD_NUMBER} -p 808${BUILD_NUMBER}:8082 basic_img:${BUILD_NUMBER}'
            }
        }
    }
}
````

---

## 🐳 Dockerfile

```dockerfile
FROM amazonlinux:latest
LABEL maintainer="SK-NAGUL <sknagul.awsdevops@gmail.com>"
RUN yum update -y
RUN yum install python3 python3-pip pip -y
RUN pip install flask
COPY app.py /opt/python_webapp/app.py
CMD FLASK_APP=/opt/python_webapp/app.py flask run --host=0.0.0.0 --port=8082
EXPOSE 8082
```

---

## 🧠 Flask App (app.py)

```python
from flask import Flask

app = Flask(__name__)

@app.route("/")
def main():
    return "Welcome to Batch16d!"

@app.route("/how are you")
def hello():
    return "I am good, how about you?"

if __name__ == "__main__":
    app.run()
```

---

## 🔁 CI/CD Flow

1. **Jenkins pulls code** from GitHub (main branch)
2. **Builds Docker image** using the Dockerfile
3. **Runs Docker container** exposing the app on port `808X`
4. Access the Flask app via
   👉 `http://<EC2_PUBLIC_IP>:808X/`

---

## 🧩 Plugins Installed in Jenkins

* **Pipeline Stage View**
* **Blue Ocean**

These provide visual pipeline tracking and improved UI for builds.

---

## ✅ Output

When deployed successfully:

* Visiting `http://<EC2_PUBLIC_IP>:808X/` → shows:
  **“Welcome to Batch16d!”**
* Visiting `http://<EC2_PUBLIC_IP>:808X/how are you` → shows:
  **“I am good, how about you?”**

---

## 🧾 Author

**👤 SK Nagul**
📧 *[sknagul.awsdevops@gmail.com](mailto:sknagul.awsdevops@gmail.com)*
💼 *AWS | DevOps Enthusiast | Continuous Learner*

---

## ⭐ Future Enhancements

* Add automated testing stage in Jenkins
* Push Docker image to DockerHub or ECR
* Deploy to Kubernetes cluster

That helps if you want to use it in your **resume or portfolio**.
```

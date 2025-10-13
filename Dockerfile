FROM amazonlinux:latest 
LABEL maintainer="MADHU KIRAN <devopstraininghub@gmail.com>" 
RUN yum update -y 
RUN yum install python3 python3-pip pip -y 
RUN pip install flask
COPY app.py /opt/python_webapp/app.py
CMD FLASK_APP=/opt/python_webapp/app.py flask run --host=0.0.0.0 --port=8080
EXPOSE 8080

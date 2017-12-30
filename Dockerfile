FROM python:3.6
MAINTAINER geod
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
#ENTRYPOINT ["python"]
CMD ["python", "w4156/app.py"]

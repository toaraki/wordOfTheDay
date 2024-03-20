FROM registry.access.redhat.com/ubi9/python-39:1-117.1684741281

# By default, listen on port 8081
EXPOSE 8081/tcp
ENV FLASK_PORT=8081
ENV OTEL_PYTHON_LOGGING_AUTO_INSTRUMENTATION_ENABLED=true
ENV OTEL_SERVICE_NAME="tempo-sample.openshift-tempo-operator.svc"

# Set the working directory in the container
WORKDIR /projects

# Copy the content of the local src directory to the working directory
COPY . .

# Install any dependencies
RUN \
  if [ -f requirements.txt ]; \
    then pip install -r requirements.txt; \
  elif [ `ls -1q *.txt | wc -l` == 1 ]; \
    then pip install -r *.txt; \
  fi

# Specify the command to run on container start
##  CMD ["opentelemetry-instrument", \
##      "--traces_exporter", "console", \
##      "--metrics_exporter", "console", \
##      "--logs_exporter", "console", \
##      "--service_name", "dice-server", \
##      "flask", "run", "--host", "0.0.0.0", "-p", "8081"]
CMD ["opentelemetry-instrument", "--logs_exporter", "otlp", "flask", "run", "--host", "--debug", "0.0.0.0", "-p", "8081"]

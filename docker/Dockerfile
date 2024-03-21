FROM registry.access.redhat.com/ubi9/python-39:1-117.1684741281
#FROM fullstorydev/grpcurl:latest

# By default, listen on port 8081
EXPOSE 8081/tcp
ENV FLASK_PORT=8081
ENV OTEL_PYTHON_LOGGING_AUTO_INSTRUMENTATION_ENABLED=true
#ENV OTEL_EXPORTER_OTLP_TRACES_ENDPOINT="http://tempo-sample.openshift-tempo-operator.svc:4317"
ENV OTEL_EXPORTER_OTLP_TRACES_ENDPOINT="http://tempo-sample.openshift-tempo-operator.svc:16685"

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

RUN \
  go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest

# Specify the command to run on container start
##  CMD ["opentelemetry-instrument", \
##      "--traces_exporter", "console", \
##      "--metrics_exporter", "console", \
##      "--logs_exporter", "console", \
##      "--service_name", "dice-server", \
##      "flask", "run", "--host", "0.0.0.0", "-p", "8081"]
## CMD ["opentelemetry-instrument", "--log_level", "debug", "--logs_exporter", "otlp,console", "--exporter_otlp_endpoint", "tempo-sample.openshift-tempo-oerator.svc:4317", "flask", "run", "--debug", "--host", "0.0.0.0", "-p", "8081"]
CMD ["opentelemetry-instrument", "--log_level", "debug", "--logs_exporter", "console", "flask", "run", "--debug", "--host", "0.0.0.0", "-p", "8081"]

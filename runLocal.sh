#!/bin/bash

export OTEL_PYTHON_LOGGING_AUTO_INSTRUMENTATION_ENABLED=true
export OTEL_EXPORTER_OTLP_TRACES_ENDPOINT="http://localhost:4317" 
opentelemetry-instrument --logs_exporter otlp flask run -p 8080

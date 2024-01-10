#!/bin/bash

# Run tests and generate coverage report
bundle exec rspec

# Parse the generated coverage report
COVERAGE=$(grep covered < coverage/.last_run.json | sed 's/[^0-9.]//g')

# Define the minimum acceptable coverage percentage
MIN_COVERAGE=85

if (( $(echo "$COVERAGE < $MIN_COVERAGE" | bc -l) )); then
  echo "Test coverage ($COVERAGE%) is below the acceptable threshold ($MIN_COVERAGE%)."
  exit 1
fi

echo "Test coverage ($COVERAGE%) is acceptable."
exit 0

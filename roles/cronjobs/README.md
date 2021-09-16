# Cronjob Role

## Example
cronjobs:
  - name: Test
    job: echo test
    user: fuzzy
    minute: 0
    hour: */6
    day: 1
    month: 1
    weekday: 1
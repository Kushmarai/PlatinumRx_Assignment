# 1) Given number of minutes, convert it into human readable form.
# Example :
# 130 becomes “2 hrs 10 minutes”
# 110 becomes “1hr 50minutes”

def convert_minutes(total_minutes):
    hours = total_minutes // 60
    minutes = total_minutes % 60
    
    if hours == 0:
        return f"{minutes} minutes"
    elif minutes == 0:
        return f"{hours} hrs"
    else:
        return f"{hours} hrs {minutes} minutes"

# Test cases
print(convert_minutes(130))   # 2 hrs 10 minutes
print(convert_minutes(110))   # 1 hrs 50 minutes
print(convert_minutes(60))    # 1 hrs
print(convert_minutes(45))    # 45 minutes
print(convert_minutes(0))     # 0 minutes
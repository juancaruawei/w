<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .salary-display {
            font-size: 32px;
            font-weight: bold;
            margin: 20px 0;
            color: #2383E2;
        }
        .info-box {
            background-color: #f1f1f1;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .time-display {
            font-size: 18px;
            margin-bottom: 10px;
        }
        .stats {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 20px;
        }
        .stat-box {
            flex: 1;
            min-width: 150px;
            padding: 10px;
            background-color: #e9f5ff;
            border-radius: 5px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Real-Time Salary Clock</h1>
        
        <div class="info-box">
            <p>Hourly rate: 213.09 NOK</p>
            <p>Working hours: 8 AM - 4 PM (Monday to Friday)</p>
            <p>Daily earnings: 1,704.72 NOK</p>
            <p>Weekly earnings: 8,523.60 NOK</p>
        </div>
        
        <div class="time-display">Current time: <span id="current-time"></span></div>
        
        <div>
            <p>Earned today:</p>
            <div class="salary-display" id="today-salary">0.00 NOK</div>
        </div>
        
        <div class="stats">
            <div class="stat-box">
                <p>This week</p>
                <div id="week-salary">0.00 NOK</div>
            </div>
            <div class="stat-box">
                <p>This month</p>
                <div id="month-salary">0.00 NOK</div>
            </div>
        </div>
    </div>

    <script>
        // Constants
        const HOURLY_RATE = 213.09; // NOK per hour
        const WORK_START_HOUR = 8; // 8 AM
        const WORK_END_HOUR = 16; // 4 PM
        const SECONDS_PER_HOUR = 3600;
        const NOK_PER_SECOND = HOURLY_RATE / SECONDS_PER_HOUR;
        
        function updateSalary() {
            const now = new Date();
            const currentHour = now.getHours();
            const currentMinute = now.getMinutes();
            const currentSecond = now.getSeconds();
            const currentDay = now.getDay(); // 0 is Sunday, 1 is Monday, etc.
            
            // Update current time display
            document.getElementById('current-time').textContent = now.toLocaleTimeString();
            
            // Check if it's a workday (Monday to Friday)
            const isWorkday = currentDay >= 1 && currentDay <= 5;
            
            // Check if it's during working hours
            const isDuringWorkHours = currentHour >= WORK_START_HOUR && currentHour < WORK_END_HOUR;
            
            let todaySalary = 0;
            
            if (isWorkday) {
                if (currentHour < WORK_START_HOUR) {
                    // Before work starts
                    todaySalary = 0;
                } else if (currentHour >= WORK_END_HOUR) {
                    // After work ends, full day salary
                    todaySalary = 8 * HOURLY_RATE;
                } else {
                    // During work hours
                    const hoursWorked = (currentHour - WORK_START_HOUR) + (currentMinute / 60) + (currentSecond / 3600);
                    todaySalary = hoursWorked * HOURLY_RATE;
                }
            }
            
            // Calculate week salary
            let weekSalary = 0;
            const today = now.getDay();
            
            // For past days in the week
            for (let day = 1; day < today; day++) {
                if (day >= 1 && day <= 5) { // Weekdays only
                    weekSalary += 8 * HOURLY_RATE;
                }
            }
            
            // Add today's salary
            weekSalary += todaySalary;
            
            // Calculate month salary (simplified - assumes 4 complete weeks + current partial week)
            // For a more accurate calculation, you would need to determine the exact working days in the month
            const completedWeeks = Math.floor((now.getDate() - 1) / 7);
            const monthSalary = (completedWeeks * 5 * 8 * HOURLY_RATE) + weekSalary;
            
            // Update the displays
            document.getElementById('today-salary').textContent = todaySalary.toFixed(2) + ' NOK';
            document.getElementById('week-salary').textContent = weekSalary.toFixed(2) + ' NOK';
            document.getElementById('month-salary').textContent = monthSalary.toFixed(2) + ' NOK';
        }
        
        // Update immediately and then every second
        updateSalary();
        setInterval(updateSalary, 1000);
    </script>
</body>
</html>

# 🔁 Text File Frequency Logger

A Bash script that scans `.txt` files hourly, searches for a randomly chosen name from a mapping file, counts its frequency in each file, and logs the results with a timestamp.

---

## ⚠️ Requirements

- Unix-based system (macOS/Linux)
- Bash shell
- `awk`, `grep`, `wc`, `date` (These are common utilities available by default on most Unix-based systems)
- Proper paths defined in the script:
  - `TEXT_DIR`: Directory containing `.txt` files to scan
  - `CSV_FILE`: Output CSV file for logging frequencies
  - `ARCHIVE_DIR`: Directory to store timestamp logs
  - `NAME_MAP`: CSV file mapping numbers to names


---

## 📋 Overview

This script is designed to:

- Select a random number between `1` and `20`.
- Use that number to pick a corresponding name from `name_map.csv`.
- Count how often the name appears in each `.txt` file in the `input/` directory (case-insensitive, whole word).
- Log results in `output.csv` and archive timestamps.

---
## 🗂️ Folder Structure
mentor_cmdp/  
├── input/ # Folder containing .txt files to scan  
│ ├── first.txt  
│ ├── second.txt  
│ └── third.txt  
├── archive/ # Stores timestamp logs  
│ ├── first.txt_access_timestamp.txt  
│ ├── second.txt_access_timestamp.txt  
│ ├── third.txt_access_timestamp.txt  
│ └── timestamp_archive.txt  
├── output.csv # Output file containing frequency logs  
└── name_map.csv # Mapping from numbers to names  

## 📄 name_map.csv Format (example)
Should contain **at least 20 lines** like the following:  
1, Priya  
2, Rohan  

 ## 📝 Output Format: `output.csv` (example)
File Name,Name,Frequency,Timestamp  
first.txt,Tanvi,2,2025-03-03 22:00:00  
second.txt,Tanvi,2,2025-03-03 22:00:00  
third.txt,Tanvi,2,2025-03-03 22:00:00  

File Name: name of the processed file.
Name: the name searched for.
Frequency: number of matches (case-insensitive, whole word).
Timestamp: when the file was processed.
## 🕒 Cron Setup

To run the script **hourly** using `cron`, follow these steps:

1. Open the crontab configuration by running the following command in your terminal:  
    ```bash  
    crontab -e  

2. Add the following line to schedule the script to run every hour:    
     #Replace /path/to/your/script.sh with the absolute path to your script.  
     #The 0 * * * * part tells cron to run the script at the start of every hour.
    ```bash 
    0 * * * * /path/to/your/script.sh  
      
3. Save and close the crontab file. In most editors, you can do this by pressing Ctrl + X, then Y, followed by Enter.  
4. Make sure the script is executable by running:  
    ```bash
    chmod +x /path/to/your/script.sh     



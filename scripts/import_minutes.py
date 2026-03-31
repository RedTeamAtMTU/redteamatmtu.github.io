#!/usr/bin/env python3

import pyperclip
import re
from datetime import datetime
import os

def main():
    # Read template
    with open('template.md', 'r') as f:
        template = f.read()

    # Get clipboard content
    clipboard_content = pyperclip.paste()
    if not clipboard_content:
        print("Clipboard is empty!")
        return

    # Split into lines and process first line for date
    lines = clipboard_content.split('\n')
    first_line = lines[0] if lines else ""

    # Extract date from first line (format like "9/17/20")
    date_match = re.search(r'(\d{1,2}/\d{1,2}/\d{2,4})', first_line)
    if not date_match:
        print("Could not find date in first line!")
        return

    date_str = date_match.group(1)
    try:
        # Parse date (handling both 2-digit and 4-digit years)
        if len(date_str.split('/')[-1]) == 2:
            parsed_date = datetime.strptime(date_str, '%m/%d/%y')
        else:
            parsed_date = datetime.strptime(date_str, '%m/%d/%Y')

        formatted_date = parsed_date.strftime('%Y-%m-%d')
    except ValueError:
        print("Could not parse date!")
        return

    # Create filename
    filename = f"{formatted_date}.md"
    if os.path.exists(filename):
        print(f"File {filename} already exists!")
        return

    # Process template
    # Replace date
    processed_content = template.replace('date: "2006-01-02"', f'date: "{formatted_date}"')
    # Set draft to false
    processed_content = processed_content.replace('draft: true', 'draft: false')

    # Split into frontmatter and content
    frontmatter_end = processed_content.find('---', 3)  # Find second ---
    if frontmatter_end == -1:
        print("Invalid template format!")
        return

    frontmatter = processed_content[:frontmatter_end + 3]
    rest_of_template = processed_content[frontmatter_end + 3:].strip()

    # Get the content from clipboard (excluding first line)
    minutes_content = '\n'.join(lines[1:]).strip()

    # relace bullet points
    minutes_content = re.sub(r'[•*]\s*', '- ', minutes_content)
    # News -> ## News
    minutes_content = re.sub(r'^[Nn]ews', r'## News', minutes_content, flags=re.MULTILINE)
    # Reminders -> ## Reminders
    minutes_content = re.sub(r'^[Rr]eminders', r'## Reminders', minutes_content, flags=re.MULTILINE)
    # Talk: -> ## Talk:
    minutes_content = re.sub(r'^[Tt]alk:', r'## Talk:', minutes_content, flags=re.MULTILINE)
    # "Presentation by" -> ## Presentation by
    #minutes_content = re.sub(r'^(.* [Bb]y .*)\n^- ', r'## \1\n- ', minutes_content, flags=re.MULTILINE)
    #minutes_content = re.sub(r'^(.* [Bb]y )', r'## \1', minutes_content, flags=re.MULTILINE)

    # Combine everything
    final_content = f"{frontmatter}\n\n{minutes_content}"
    if rest_of_template:
        final_content += f"\n\n{rest_of_template}"

    # Show content to user and ask for title
    print(f"\n===== {formatted_date} =====")
    print(minutes_content)
    print("===========================\n")

    title = input("Enter title for the meeting minutes: ").strip()
    if not title:
        print("No title provided, using default")
        title = "Meeting Topic"

    # Insert title
    final_content = final_content.replace('title: Meeting Topic', f'title: "{title}"')

    # Write to file
    with open(filename, 'w') as f:
        f.write(final_content)

    print(f"Meeting minutes saved to {filename}")

if __name__ == "__main__":
    main()

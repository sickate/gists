import requests
from bs4 import BeautifulSoup4

# sample code to get href
html = requests.get('http://www.msj1.com/archives/6216.html').content
soup = BeautifulSoup(html, 'html.parser', from_encoding='utf-8')
soup.select('#content > div:nth-child(11) > table:nth-child(2) > tbody > tr > td:nth-child(1) > a:nth-child(1)')['href']

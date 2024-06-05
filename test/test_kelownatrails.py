from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import pytest

URL = "https://testing-replica-3a311.web.app"


@pytest.fixture
def driver():
    chrome_options = Options()
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-dev-shm-usage")
    chrome_options.add_argument("--disable-gpu")
    chrome_options.add_argument("--headless")
    service = Service("/usr/local/bin/chromedriver")
    driver = webdriver.Chrome(service=service, options=chrome_options)
    try:
        driver.get(URL)
        print(driver.title)
        driver.find_element(By.ID, "GroupSize").send_keys("5")
        yield driver
        driver.quit()
    except Exception as e:
        driver.quit()
        raise e


def test_add_member(driver):
    add_member(driver)
    output = driver.find_element(By.ID, "members").text
    assert "Smith, Anne" in output


def add_member(driver):
    driver.find_element(By.ID, "lastname").send_keys("Smith")
    driver.find_element(By.ID, "firstname").send_keys("Anne")
    driver.find_element(By.ID, "addMemberBtn").click()

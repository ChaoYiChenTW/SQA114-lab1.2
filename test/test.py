from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By


class TestKelownaWebsite:

    def __init__(self) -> None:
        driver = webdriver.Chrome()
        driver.get("https://testing-replica-3a311.web.app")
        print(driver.title)


if __name__ == "__main__":
    test = TestKelownaWebsite()

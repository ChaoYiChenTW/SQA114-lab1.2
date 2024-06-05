from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys


class TestKelownaWebsite:

    def __init__(self) -> None:
        chrome_options = Options()
        chrome_options.add_argument("--headless")
        chrome_options.add_argument("--no-sandbox")
        chrome_options.add_argument("--disable-dev-shm-usage")
        chrome_options.add_argument(
            "--remote-debugging-port=9222"
        )  # optional, useful for debugging
        chrome_options.add_argument(
            "--disable-gpu"
        )  # Disable GPU acceleration (usually not needed, but can help)

        service = Service("/usr/local/bin/chromedriver")  # Path to your ChromeDriver
        driver = webdriver.Chrome(service=service, options=chrome_options)

        driver.get("https://testing-replica-3a311.web.app")
        print(driver.title)


if __name__ == "__main__":
    test = TestKelownaWebsite()

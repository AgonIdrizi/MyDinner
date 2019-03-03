options = Selenium::WebDriver::Chrome::Options.new(args: ["headless"])

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options,
  )
end
Capybara.asset_host = "http://localhost:3000"
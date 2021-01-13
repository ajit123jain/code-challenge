require "test_helper"
require "application_system_test_case"

class CompaniesControllerTest < ApplicationSystemTestCase

  def setup
    @company = companies(:main_street)
  end

  test "Index" do
    visit companies_path

    assert_text "Companies"
    assert_text "Hometown Painting"
    assert_text "Wolf Painting"
    assert_text "Name"
    assert_text "Action"
  end

  test "Show" do
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    assert_text "Examples: Atlanta"
  end

  test "Update" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: " Test", fill_options: {clear: :none})
      fill_in("company_zip_code", with: "93009")
      click_button "Update Company"
    end
    assert_text "Changes Saved"

    @company.reload
    assert_equal "Main Street Test", @company.name
    assert_equal "93009", @company.zip_code
  end

  test "Create" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: 'new_test_company@getmainstreet.com')
      select("Commercial Painting", from: "company_services").select_option
      click_button 'Create Company'
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "New Test Company", last_company.name
    assert_equal "28173", last_company.zip_code
  end

  test "invalid email" do 
    visit edit_company_path(@company)
    
    within("form#edit_company_#{@company.id}") do
      fill_in("company_email", with: "test@gmail.com", fill_options: { clear: :backspace })
      click_button "Update Company"
    end
    
    assert_text "The email should have 'getmainstreet.com'"
  end

  test "test city state with valid zipcode" do 
    visit edit_company_path(@company)
    
    within("form#edit_company_#{@company.id}") do
      fill_in("company_zip_code", with: "75009", fill_options: { clear: :backspace })
      click_button "Update Company"
    end
    @company.reload 
    assert_equal "Celina", @company.city 
    assert_equal "TX", @company.state 
  end

  test "test brand color update" do 
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_brand_color", with: "#0000ff", fill_options: { clear: :backspace })
      click_button "Update Company"
    end
    @company.reload 
    assert_equal "#0000ff", @company.brand_color
  end

  test "delete the company" do
    visit companies_path

    no_of_companies = all('a.btn-danger').size
    all("a.btn-danger").first.click
    page.driver.browser.switch_to.alert.accept
    assert_text "Company has been successfully deleted."
    assert_equal all('a.btn-danger').size, (no_of_companies - 1)
  end
end

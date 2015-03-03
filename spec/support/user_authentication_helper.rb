module UserAuthenticationHelper

  def login(student)
    request.session[:student_id] = student.id
  end

  def login_via_web(user)
    visit login_as_student_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end

end

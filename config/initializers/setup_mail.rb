ActionMailer::Base.smtp_settings = {
    address:              "localhost",
    port:                 25,
    domain:               'localhost.localdomain',
    user_name:            nil,
    password:             nil,
    authentication:       nil,
    enable_starttls_auto: true

    #address:              "smtp.gmail.com",
    #port:                 587,
    #domain:               'gmail.com',
    #user_name:            "gmail account",
    #password:             "gmail password",
    #authentication:       "plain",
    #enable_starttls_auto: true

}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
#Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
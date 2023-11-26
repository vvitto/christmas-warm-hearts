module ApplicationHelper
  RECAPTCHA_SITE_KEY = Rails.configuration.recaptcha[:recaptcha_site_key]

  def include_recaptcha_js
    raw %Q{
      <script src="https://www.google.com/recaptcha/api.js?render=#{RECAPTCHA_SITE_KEY}"></script>
    }
  end

  def recaptcha_execute()
    raw %Q{
      <input name="recaptcha_site_key" type="hidden" id="recaptcha_site_key" value="#{RECAPTCHA_SITE_KEY}"/>
      <input name="recaptcha_token" type="hidden" id="recaptcha_token"/>
    }
  end
end

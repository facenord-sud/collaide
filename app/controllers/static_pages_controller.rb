# -*- encoding : utf-8 -*-
class StaticPagesController < ApplicationController
  def home
    unless params[ :locale]
      # it takes I18n.locale from the previous example set_locale as before_filter in application controller
      redirect_to eval("root_#{I18n.locale}_path")
    end
    @documents = Document::Document.valid.order('created_at DESC').limit(5).to_a
    @ads = Advertisement::Advertisement.order('created_at DESC').limit(5).includes(:book).to_a
    @activities = Activity::Activity.order("created_at desc").limit(6)
    @site_news = SiteNew.new
    add_breadcrumb(t('static_pages.home.bc'))
  end

  def help
    add_breadcrumb(t('static_pages.help.bc'))
  end

  def about
    add_breadcrumb(t('static_pages.about.bc'))
  end

  def board

  end

  def contact
    add_breadcrumb(t('static_pages.contact.bc'))
    @contact = Contact.new
  end

  def change_lang

  end

  def rules
    add_breadcrumb(t('static_pages.rules.bc'))
  end

  def partners
    add_breadcrumb(t('static_pages.partners.bc'))
  end

  def send_email
    @action = Contact.new params[:contact]
    if @action.valid?
      ActionMailer::Base.mail(
          from: @action.email, :to => 'contact@collaide.com',
          subject: @action.subject,
          body: @action.content
      ).deliver
      redirect_to contact_path, notice: t('static_pages.contact.success', email: @action.email, subject: @action.subject)
    else
      render action: :contact
    end
  end
end

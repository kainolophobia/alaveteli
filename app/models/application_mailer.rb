# models/application_mailer.rb:
# Shared code between different mailers.
#
# Copyright (c) 2008 UK Citizens Online Democracy. All rights reserved.
# Email: francis@mysociety.org; WWW: http://www.mysociety.org/
#
# $Id: application_mailer.rb,v 1.8 2009-02-09 10:37:12 francis Exp $

class ApplicationMailer < ActionMailer::Base
    # Include all the functions views get, as emails call similar things.
    helper :application

    # This really should be the default - otherwise you lose any information
    # about the errors, and have to do error checking on return codes.
    self.raise_delivery_errors = true

    def contact_from_name_and_email
        contact_name = MySociety::Config.get("CONTACT_NAME", 'Alaveteli')
        contact_email = MySociety::Config.get("CONTACT_EMAIL", 'contact@localhost')
        return "#{contact_name} <#{contact_email}>"
    end

    def blackhole_email
        MySociety::Config.get("BLACKHOLE_PREFIX", 'do-not-reply-to-this-address')+"@"+MySociety::Config.get("INCOMING_EMAIL_DOMAIN", "localhost")
    end

    # URL generating functions are needed by all controllers (for redirects),
    # views (for links) and mailers (for use in emails), so include them into
    # all of all.
    include LinkToHelper
    
    # Site-wide access to configuration settings
    include ConfigHelper
end


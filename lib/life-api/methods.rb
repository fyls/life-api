# encoding: utf-8

module Life
  class API
    def sign_in
      xml = request('signIn', { msisdn: @msisdn, superPassword: @password })
      @token  = xml['token']
      @sub_id = xml['subId']
      return xml
    end

    def sign_out
      request('signOut', { msisdn: @msisdn, subId: @sub_id })
    end

    def get_token
      request('getToken', { msisdn: @msisdn, subId: @sub_id })
    end

    def get_summary_data
      request('getSummaryData', base_api_parameters)
    end

    def get_services
      request('getServices', base_api_parameters)
    end

    def get_available_tariffs
      request('getAvailableTariffs', base_api_parameters)
    end

    def get_balances
      request('getBalances', base_api_parameters)
    end

  end
end

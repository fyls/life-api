# encoding: utf-8

# The list of available API method names:
# (13/22)
#
# [-] activateDeactivateService
# [+] callMeBack
# [-] changeLanguage
# [+] changeSuperPassword
# [-] changeTariff
# [+] getAvailableTariffs
# [+] getBalances
# [+] getExpensesSummary
# [+] getLanguages
# [+] getPaymentsHistory
# [-] getSeparateBalances
# [+] getServices
# [+] getSummaryData
# [+] getToken
# [-] getUIProperties
# [-] offerAction
# [-] refillBalanceByScratchCard
# [-] removeFromPreProcessing
# [+] requestBalanceTransfer
# [+] signIn
# [+] signOut
# [-] transferBalance

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

    def change_super_password(old_password, new_password)
      request('changeSuperPassword', base_api_parameters.merge({ oldPassword: old_password, newPassword: new_password }))
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

    def get_languages
      request('getLanguages', base_api_parameters)
    end

    def call_me_back(msisdn_b)
      request('callMeBack', base_api_parameters.merge({ msisdnB: msisdn_b }))
    end

    def request_balance_transfer(msisdn_b)
      request('requestBalanceTransfer', base_api_parameters.merge({ msisdnB: msisdn_b }))
    end

    # @param [String] month_period in format 'yyyy-MM'
    #
    def get_payments_history(month_period)
      request('getPaymentsHistory', base_api_parameters.merge({ monthPeriod: month_period }))
    end

    # @param [String] month_period in format 'yyyy-MM'
    #
    def get_expenses_summary(month_period)
      request('getExpensesSummary', base_api_parameters.merge({ monthPeriod: month_period }))
    end

  end
end

require 'ads_common/api'
require 'ads_common/api_config'
require 'ads_common/savon_headers/base_header_handler'
require 'ads_common/credential_handler'
require 'ads_common/errors'
require 'ads_common/http'
require 'ads_common/savon_service'
require 'ads_common/build/savon_generator'
require 'ads_common/build/savon_registry'
require 'ads_common/parameters_validator'

####### AdsCommon Overriden for Adcenter #########
module AdsCommonForAdcenter
	include AdsCommon
end
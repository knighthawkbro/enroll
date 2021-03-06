module Config::AcaHelper
  def aca_state_abbreviation
    Settings.aca.state_abbreviation
  end

  def aca_state_name
    Settings.aca.state_name
  end

  def aca_primary_market
    Settings.aca.market_kinds.first
  end

  def aca_shop_market_employer_family_contribution_percent_minimum
    @aca_shop_market_employer_family_contribution_percent_minimum ||= Settings.aca.shop_market.employer_family_contribution_percent_minimum
  end

  def aca_shop_market_employer_contribution_percent_minimum
    @aca_shop_market_employer_contribution_percent_minimum ||= Settings.aca.shop_market.employer_contribution_percent_minimum
  end

  def aca_shop_market_valid_employer_attestation_documents_url
    @aca_shop_market_valid_employer_attestation_documents_url ||= Settings.aca.shop_market.valid_employer_attestation_documents_url
  end


  # Allows us to conditionally display General Agency related links and information
  # This can be enabled or disabled in config/settings.yml
  # @return { True } if Settings.aca.general_agency_enabled
  # @return { False } otherwise
  def general_agency_enabled?
    Settings.aca.general_agency_enabled
  end

  def dental_market_enabled?
    Settings.aca.dental_market_enabled
  end

  def individual_market_is_enabled?
    @individual_market_is_enabled ||= Settings.aca.market_kinds.include?("individual")
  end

  def offer_sole_source?
    @offer_sole_source ||= Settings.aca.plan_options_available.include?("sole_source")
  end

  def enabled_sole_source_years
    @enabled_sole_source_years ||= Settings.aca.plan_option_years.sole_source_carriers_available
  end

  def offers_metal_level?
    @offer_metal_level ||= Settings.aca.plan_options_available.include?("metal_level")
  end

  def metal_levels_explaned
    response = ""
    metal_level_contributions = {
      'bronze': '60%',
      'silver': '70%',
      'gold': '80%',
      'platinum': '90%'
    }.with_indifferent_access
    reference_plans_for_metal_level.each_with_index do |level, index|
      if metal_level_contributions[level]
        if index == 0
          response << "#{level.capitalize} means the plan is expected to pay #{metal_level_contributions[level]} of expenses for an average population of consumers"
        elsif (index == reference_plans_for_metal_level.length - 2) # subtracting 2 because of dental
          response << ", and #{level.capitalize} #{metal_level_contributions[level]}."
        else
          response << ", #{level.capitalize} #{metal_level_contributions[level]}"
        end
      end
    end
    response
  end

  def enabled_metal_level_years
    @enabled_metal_level_years ||= Settings.aca.plan_option_years.metal_level_carriers_available
  end

  def offers_single_carrier?
    @offer_single_carrier ||= Settings.aca.plan_options_available.include?("single_carrier")
  end

  def enabled_single_carrier_years
    @enabled_single_carrier_years ||= Settings.aca.plan_option_years.single_carriers_available
  end

  def offers_single_plan?
    @offer_single_plan ||= Settings.aca.plan_options_available.include?("single_plan")
  end

  def offers_nationwide_plans?
    @offers_nationwide_plans ||= Settings.aca.nationwide_markets
  end

  def check_plan_options_title
    Settings.site.plan_options_title_for_ma
  end

  def reference_plans_for_metal_level
    Settings.aca.reference_carriers_for_metal_level
  end

  def fetch_plan_title_for_sole_source
    Settings.plan_option_titles.sole_source
  end

  def fetch_plan_title_for_metal_level
    Settings.plan_option_titles.metal_level
  end

  def fetch_plan_title_for_single_carrier
    Settings.plan_option_titles.single_carrier
  end

  def carrier_special_plan_identifier_namespace
    @carrier_special_plan_identifier_namespace ||= Settings.aca.carrier_special_plan_identifier_namespace
  end

  def market_rating_areas
    @market_rating_areas ||= Settings.aca.rating_areas
  end

  def multiple_market_rating_areas?
    @multiple_market_rating_areas ||= Settings.aca.rating_areas.many?
  end

  def use_simple_employer_calculation_model?
    @use_simple_employer_calculation_model ||= (Settings.aca.use_simple_employer_calculation_model.to_s.downcase == "true")
  end

  def site_broker_quoting_enabled?
   Settings.site.broker_quoting_enabled
  end

end

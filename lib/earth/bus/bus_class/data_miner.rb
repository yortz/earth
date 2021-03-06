BusClass.class_eval do
  data_miner do
    schema Earth.database_options do
      string 'name'
      float  'distance'
      string 'distance_units'
      float  'passengers'
      float  'speed'
      string 'speed_units'
      float  'duration'
      string 'duration_units'
      float  'diesel_intensity'
      string 'diesel_intensity_units'
      float  'gasoline_intensity'
      string 'gasoline_intensity_units'
      float  'alternative_fuels_intensity'
      string 'alternative_fuels_intensity_units'
      float  'fugitive_air_conditioning_emission'
      string 'fugitive_air_conditioning_emission_units'
    end
    
    process "Define some necessary conversions" do
      Conversions.register :gallons_per_mile, :litres_per_kilometre, 2.35214583
      Conversions.register :pounds_per_mile, :kilograms_per_kilometre, 0.281849232
    end
    
    import "a list of bus classes and pre-calculated trip and fuel use characteristics",
           :url => 'http://static.brighterplanet.com/science/data/transport/bus/bus_classes.csv' do
      key   'name'
      store 'distance', :from_units => :miles, :to_units => :kilometres
      store 'passengers'
      store 'speed', :from_units => :miles, :to_units => :kilometres
      store 'duration', :units => :minutes
      store 'diesel_intensity', :field_name => 'diesel_per_vehicle_mile', :from_units => :gallons_per_mile, :to_units => :litres_per_kilometre
      store 'gasoline_intensity', :field_name => 'gasoline_per_vehicle_mile', :from_units => :gallons_per_mile, :to_units => :litres_per_kilometre
      store 'alternative_fuels_intensity', :field_name => 'alternative_fuels_per_vehicle_mile', :from_units => :gallons_per_mile, :to_units => :litres_per_kilometre
      store 'fugitive_air_conditioning_emission', :field_name => 'fugitive_air_conditioning_emission_per_vehicle_mile', :from_units => :pounds_per_mile, :to_units => :kilograms_per_kilometre
    end
  end
end


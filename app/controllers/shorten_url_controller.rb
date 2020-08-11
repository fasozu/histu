class ShortenUrlController < ApplicationController
  def index
  end

  def generate
    #byebug


    #@shrunkenUrl = ShrunkenUrl.create(
    #  url: params["url"], 
    #  short_code: rand(1..999999)
    #  #short_code: "T1"      
    #)
    
    @shrunkenUrl = ShrunkenUrl.new
    @shrunkenUrl.url = params["url"]
    @shrunkenUrl.short_code = generate_random_code
    
    continueSearch = true
    tries = 0

    # #try many times if the random code is already taken
    while continueSearch do
      begin
        @shrunkenUrl.save!
        continueSearch = false
      rescue ActiveRecord::RecordInvalid => e        
        if e.message == 'Validation failed: Short code has already been taken'
          @shrunkenUrl.short_code = generate_random_code          
          tries += 1

          logger.debug "Tries #{tries}"
          if tries >=  Rails.configuration.short_code_generator_max_tries 
            continueSearch = false
          end 
        else
          continueSearch = false         
        end
      end
    end

    render "index"
    #render plain: @shrunkenUrl.inspect        
  end 

  def redirect_url
    @shrunkenUrl = ShrunkenUrl.find_by(short_code: params["short_code"])
    if @shrunkenUrl
      redirect_to @shrunkenUrl.url
    else
      render plain: 'Not Found',  status: 404
    end
    
  end 
  
  def debug
    byebug
    render plain: "FINISH DEBUGGING!"        
  end

  private
    def generate_random_code      
      numberRecords = ShrunkenUrl.count 
      if numberRecords == 0 
        numberRecords = 1
      end

      options = Rails.configuration.short_code_generator_char_options
      numberOptions = options.length
      probabilityRepeated = Rails.configuration.short_code_generator_max_probability_repeated
      minimumSpace = (numberRecords/probabilityRepeated).ceil()

      lengthCode = Math::log(minimumSpace,numberOptions).ceil()

      code = ""
      while code.length < lengthCode do
        code += options.sample
      end

      return code
    end
  
  
end

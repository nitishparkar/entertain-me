class HomeController < ApplicationController
  def index
  end

  def recommendations
    Rails.logger.info("Selected genres: #{params[:genres]}")

    prompt = "Give me 5 short film recommendations that fit all or some of the following genres: #{params[:genres].join(', ')}. "\
      "Return this response as a json array of recommendation. Each recommendation should have only 2 keys: title and description. "\
      "Include no other commentary in the response."

    response = OpenAI::Client.new.chat(
      parameters: {
          model: "gpt-3.5-turbo", # Required.
          messages: [{ role: "user", content: prompt}], # Required.
          temperature: 0.7,
      })
    tokens_used = response['usage']['total_tokens']
    recos_raw = response.dig("choices", 0, "message", "content")

    # tokens_used = 400
    # recos_raw = "\n\n[\n  {\n    \"title\": \"The Gunfighter\",\n    \"description\": \"A gunslinger walks into a saloon and finds himself in a deadly game of cat and mouse.\",\n    \"url\": \"https://vimeo.com/72545203\"\n  },\n  {\n    \"title\": \"The Adventures of Indiana Jones\",\n    \"description\": \"A parody of the Indiana Jones films, featuring an unlikely hero on a quest for treasure.\",\n    \"url\": \"https://www.youtube.com/watch?v=VufilzHKTqk\"\n  },\n  {\n    \"title\": \"Death in Bloom\",\n    \"description\": \"A surreal dark comedy about a man who finds himself trapped in a nightmarish garden.\",\n    \"url\": \"https://vimeo.com/146789055\"\n  },\n  {\n    \"title\": \"Kung Fury\",\n    \"description\": \"A martial arts master travels through time to stop Hitler and his army of kung-fu Nazis.\",\n    \"url\": \"https://www.youtube.com/watch?v=bS5P_LAqiVg\"\n  },\n  {\n    \"title\": \"The Voorman Problem\",\n    \"description\": \"A psychiatrist is called to a prison to evaluate a patient who believes he is a god.\",\n    \"url\": \"https://vimeo.com/70160643\"\n  }\n]"

    @recos = JSON.parse(recos_raw)

    Rails.logger.info("GPT recommendations: #{recos_raw}")
    Rails.logger.info("Tokens used: #{tokens_used}")
  end

  def recommendations_template
    recos_raw = "\n\n[\n  {\n    \"title\": \"The Gunfighter\",\n    \"description\": \"A gunslinger walks into a saloon and finds himself in a deadly game of cat and mouse.\",\n    \"url\": \"https://vimeo.com/72545203\"\n  },\n  {\n    \"title\": \"The Adventures of Indiana Jones\",\n    \"description\": \"A parody of the Indiana Jones films, featuring an unlikely hero on a quest for treasure.\",\n    \"url\": \"https://www.youtube.com/watch?v=VufilzHKTqk\"\n  },\n  {\n    \"title\": \"Death in Bloom\",\n    \"description\": \"A surreal dark comedy about a man who finds himself trapped in a nightmarish garden.\",\n    \"url\": \"https://vimeo.com/146789055\"\n  },\n  {\n    \"title\": \"Kung Fury\",\n    \"description\": \"A martial arts master travels through time to stop Hitler and his army of kung-fu Nazis.\",\n    \"url\": \"https://www.youtube.com/watch?v=bS5P_LAqiVg\"\n  },\n  {\n    \"title\": \"The Voorman Problem\",\n    \"description\": \"A psychiatrist is called to a prison to evaluate a patient who believes he is a god.\",\n    \"url\": \"https://vimeo.com/70160643\"\n  }\n]"
    @recos = JSON.parse(recos_raw)

    render "recommendations"
  end
end

require 'openai'
require 'dotenv/load'
require "langchain"

# # Your existing code here
# OpenAI.configure do |config|
#     config.access_token = ENV['OPENAI_API_KEY']
# end

# client = OpenAI::Client.new

# Buat instance dari model bahasa OpenAI
llm = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])

store_info = {
    name: 'Toko Makanan Sehat Suka Rasa',
    location: 'Jl. Pahlawan No. 123, Kota Bahagia',
    opening_hours: {
      monday_to_friday: 'Jam 7 pagi hingga 9 malam',
      saturday: 'Jam 8 pagi hingga 8 malam',
      sunday: 'Libur'
    },
    products: [
      { name: 'Roti Gandum', price: 'Rp 10,000' },
      { name: 'Susu Organik', price: 'Rp 15,000' },
      { name: 'Nugget Sayuran', price: 'Rp 20,000' },
      { name: 'Smoothie Buah Segar', price: 'Rp 18,000' }
    ],
    contact: {
      phone: '0812-3456-7890',
      email: 'info@tokomakanansehatsukarasa.com'
    }
  }

  def formatted_products(products)
    products.map { |product| "#{product[:name]} (#{product[:price]})" }.join("\n      ")
  end
  

print "Pertanyaan Kamu : "
chat_question = gets.chomp
while chat_question.downcase != 'exit'
    # Gabungkan informasi toko ke dalam pertanyaan
    chat_question_with_info = <<~PROMPT
    #{chat_question}

    Informasi Toko:
    - Nama Toko: #{store_info[:name]}
    - Lokasi: #{store_info[:location]}
    - Jam Buka:
      - Senin-Jumat: #{store_info[:opening_hours][:monday_to_friday]}
      - Sabtu: #{store_info[:opening_hours][:saturday]}
      - Minggu: #{store_info[:opening_hours][:sunday]}
    - Produk yang Dijual:
      #{formatted_products(store_info[:products])}
    - Kontak:
      - Telepon: #{store_info[:contact][:phone]}
      - Email: #{store_info[:contact][:email]}
  PROMPT

    # Gunakan metode 'chat' untuk menghasilkan respons berdasarkan teks prompt
    chat_answer = llm.chat(prompt: chat_question_with_info).completion

    
    # Cetak respons
    puts "Answer: #{chat_answer}"
    
    # Dapatkan pertanyaan berikutnya dari pengguna
    print "Pertanyaan Kamu : "
    chat_question = gets.chomp
  end



# response = client.chat(
#     parameters: {
#         model: "gpt-3.5-turbo", # Required.
#         messages: [{ role: "user", content: "Indonesia ada di benua apa ?"}], # Required.
#         temperature: 0.7,
#     })

# puts response.dig("choices", 0, "message", "content")

# response = client.images.generate(
#    parameters: {
#     prompt: "make a picture of a cat wearing a bikini on the beach",
#     size: "1024x1024"
#    }
# )

# response = client.images.edit(
#     parameters: {
#       prompt: "change the background color to a solid white",
#       image: "D:\\ruby\\openai\\68747470733a2f2f692e6962622e636f2f735756683342582f64616c6c652d727562792e706e67.png"
#     }
#   )

# response = client.audio.speech(
#     parameters: {
#       model: "tts-1",
#       input: "mas azis adalah warga bulak barat, dia sangat menyukai kucing. Terlebih wanita yang menggunakan kostum kucing!",
#       voice: "alloy"
#     }
#   )
  

#   File.binwrite('demo.mp3', response)
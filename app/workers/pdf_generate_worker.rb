# frozen_string_literal: true

class PdfGenerateWorker
  include Sidekiq::Worker
  sidekiq_options queue: :pdf_generate, retry: false

  def perform(*args)
    pdf = WickedPdf.new.pdf_from_url("http://localhost:7000/orders/1", {
      page_width: "8.5in",
      page_height: "11in"
    })
    # then save to a file
    save_path = Rails.root.join("tmp", "235400.pdf")
    File.delete(save_path)
    File.open(save_path, "wb") do |file|
      file << pdf
    end
  rescue => e
    puts "app_log(INFO): #{e.message}"
  end
end

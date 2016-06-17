class HealthCheckPagesController < ApplicationController

  def index
    @food_products = FoodProduct.this_year_cooking
    @fes_dates = FesYear.this_year.fes_date.all()

    preview_pdf_page("index", "")
  end

  def no_cooking
    @food_products = FoodProduct.this_year_non_cooking
    @fes_dates = FesYear.this_year.fes_date.all()
    preview_pdf_page("no_cooking", "_no_cooking")
  end

  def preview_pdf_page(html_page_name, output_file_name)
    respond_to do |format|
      format.pdf do
        # 詳細画面のHTMLを取得
        html = render_to_string template: "health_check_pages/" + html_page_name

        # PDFKitを作成
        pdf = PDFKit.new(html, encoding: "UTF-8")

        # 画面にPDFを表示する
        # to_pdfメソッドでPDFファイルに変換する
        # 他には、to_fileメソッドでPDFファイルを作成できる
        # disposition: "inline" によりPDFはダウンロードではなく画面に表示される
        send_data pdf.to_pdf,
          filename:    "#health_check_all#{output_file_name}.pdf",
          type:        "application/pdf",
          disposition: "inline"
      end   # 副代表が登録されていない団体数を取得する
    end
  end

end

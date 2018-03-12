class MarketsController < ApplicationController
  def show
    url      = 'http://peatio.local/markets/' + params[:id] + '.json'
    response = Faraday.get(url, params.slice(:lang), 'Cookie' => request.headers['HTTP_COOKIE']).assert_success!
    @data    = JSON.load(response.body).deep_symbolize_keys
  end

private

  def fiat_ccy
    @data.fetch(:currencies).find { |ccy| ccy.fetch(:type) == 'fiat' }
  end
  helper_method :fiat_ccy
end

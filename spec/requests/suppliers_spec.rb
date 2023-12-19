# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Suppliers" do
  context "when visiting the suppliers route" do
    before do
      allow(Supplier).to receive(:fetch_all).and_return([])
    end

    context "when no country is specified" do
      it "responds successfully to the suppliers route" do
        get CSR_APP_PATH # defined in routes.rb

        expect(response).to have_http_status :successful
      end

      it "render the swiftype search type advice metatag" do
        get CSR_APP_PATH

        expect(response.body).to include("<meta class='swiftype' content='advice' data-type='string' name='search_type_filter'>")
      end

      it "render the swiftype search type everything metatag" do
        get CSR_APP_PATH

        expect(response.body).to include("<meta class='swiftype' content='everything' data-type='string' name='search_type_filter'>")
      end

      it "render the swiftype audience england metatag" do
        get CSR_APP_PATH

        expect(response.body).to include("<meta class='swiftype' content='england' data-type='string' name='audience_filter'>")
      end

      it "responds successfully to the unranked supplier detail route" do
        get "#{CSR_APP_PATH}/an-energy-supplier"

        expect(response).to have_http_status :successful
      end
    end

    context "when the country is Scotland" do
      it "responds successfully to the suppliers route" do
        get "/scotland/#{CSR_APP_PATH}"

        expect(response).to have_http_status :successful
      end

      it "responds successfully to the unranked supplier detail route" do
        get "/scotland/#{CSR_APP_PATH}/an-energy-supplier"

        expect(response).to have_http_status :successful
      end
    end

    context "when the country is Wales" do
      it "responds successfully to the suppliers route" do
        get "/wales/#{CSR_APP_PATH}"

        expect(response).to have_http_status :successful
      end

      it "responds successfully to the unranked supplier detail route" do
        get "/wales/#{CSR_APP_PATH}/an-energy-supplier"

        expect(response).to have_http_status :successful
      end

      it "renders the swiftype meta tags" do
        get "/wales/#{CSR_APP_PATH}"

        expect(response.body).to include("<meta class='swiftype' content='wales' data-type='string' name='audience_filter'>")
      end
    end

    context "when an invalid country is requested" do
      it "responds successfully to the suppliers route" do
        get "/france/#{CSR_APP_PATH}"

        expect(response).to have_http_status :not_found
      end

      it "responds successfully to the unranked supplier detail route" do
        get "/france/#{CSR_APP_PATH}/an-energy-supplier"

        expect(response).to have_http_status :not_found
      end
    end

    context "when handling 500s" do
      before do
        # rubocop:disable RSpec/AnyInstance
        allow_any_instance_of(SuppliersController).to receive(:index).and_raise(Contentful::GraphqlAdapter::UnprocessableEntityError)
        get "/"
        # rubocop:enable RSpec/AnyInstance
      end

      it "renders the 500 error page" do
        expect(response).to render_template("errors/500")
      end

      it "returns status 'server error'" do
        expect(response).to have_http_status(:server_error)
      end
    end
  end
end

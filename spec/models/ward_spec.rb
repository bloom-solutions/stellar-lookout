require 'rails_helper'

RSpec.describe Ward do

  describe ".watching" do
    let!(:ward) do
      create(:ward, {
        address: "GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7",
      })
    end

    Operation::ADDRESS_FIELDS.each do |field|
      context "given ward participated as #{field}" do
        let(:operation_body) do
          {field => "GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7"}
        end
        let(:operation) { create(:operation, body: operation_body) }

        it "includes the ward" do
          expect(described_class.watching(operation)).to include(ward)
        end
      end
    end

    context "ward did not participate" do
      let(:operation_body) do
        {
          id: "12884905987",
          paging_token: "12884905987",
          source_account: "changedmetonotmatch",
          type: "set_options",
          type_i: 5,
          master_key_weight: 0
        }
      end
      let(:operation) { create(:operation, body: operation_body) }

      it "does not include the ward" do
        expect(described_class.watching(operation)).to_not include(ward)
      end
    end
  end

end

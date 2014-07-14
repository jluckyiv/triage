require "./app/models/case_number_parser"

describe CaseNumberParser do

  subject { should respond_to :parse }
  subject { should respond_to :run }

  describe ".parse" do
    it "should parse a case number" do
      expect(CaseNumberParser.parse("IND094333")).to eq({
        :case_number => "094333",
        :case_type   => "IND",
        :court_code  => "G"
      })
    end
  end

  describe "#parse" do
    context "with invalid case number" do
      it "should return an empty hash" do
        parser = CaseNumberParser.new("")
        expect(parser.parse).to eq({})
      end
    end

    context "with case number and court code" do
      parser = CaseNumberParser.new("IND094333", court_code: "F")
      it "should return a valid hash" do
        expect(parser.parse).to eq({
          :case_number => "094333",
          :case_type   => "IND",
          :court_code  => "F"
        })
      end
    end

    context "with valid case numbers" do
      context "with RIV case" do
        parser = CaseNumberParser.new("RIV1234567")
        it "should return a valid hash" do
          expect(parser.parse).to eq({
            :case_number => "1234567",
            :case_type => "RIV",
            :court_code => "F"
          })
        end
      end

      context "with RIDIND case" do
        parser = CaseNumberParser.new("RIDIND0875342")
        it "should return a valid hash" do
          expect(parser.parse).to eq({
            :case_number => "IND0875342",
            :case_type => "RID",
            :court_code => "F"
          })
        end
      end

      context "with IND case" do
        parser = CaseNumberParser.new("IND0875342")
        it "should return a valid has" do
          expect(parser.parse).to eq({
            :case_number => "0875342",
            :case_type => "IND",
            :court_code => "G"
          })
        end
      end
    end

  end
end

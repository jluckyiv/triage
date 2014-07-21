require "./lib/case_number_parser"

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

  describe ".parse_all" do
    parser = CaseNumberParser.new
    it "should return valid hashes" do
      expect(parser.parse_all(["RIV1234567", "RID2345678"])).to eq([
        {
          :case_number => "1234567",
          :case_type => "RIV",
          :court_code => "F"
        }, {
          :case_number => "2345678",
          :case_type => "RID",
          :court_code => "F"
        }
      ])
    end
  end

  describe "#parse" do
    context "with invalid case number" do
      it "should return an empty hash" do
        parser = CaseNumberParser.new
        expect(parser.parse("")).to eq({})
      end
    end

    context "with case number hash" do
      parser = CaseNumberParser.new
      it "should return a valid hash" do
        expect(parser.parse(court_code: "F", case_type: "IND", case_number: "094333")).to eq({
          :case_number => "094333",
          :case_type   => "IND",
          :court_code  => "F"
        })
      end
    end

    context "with valid case numbers" do
      context "with RIV case" do
        parser = CaseNumberParser.new
        it "should return a valid hash" do
          expect(parser.parse("RIV1234567")).to eq({
            :case_number => "1234567",
            :case_type => "RIV",
            :court_code => "F"
          })
        end
      end

      context "with RIDIND case" do
        parser = CaseNumberParser.new
        it "should return a valid hash" do
          expect(parser.parse("RIDIND0875342")).to eq({
            :case_number => "IND0875342",
            :case_type => "RID",
            :court_code => "F"
          })
        end
      end

      context "with IND case" do
        parser = CaseNumberParser.new
        it "should return a valid has" do
          expect(parser.parse("IND0875342")).to eq({
            :case_number => "0875342",
            :case_type => "IND",
            :court_code => "G"
          })
        end
      end
    end

  end
end

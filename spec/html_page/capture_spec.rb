require "spec_helper"

describe HtmlPage::Capture do
  describe "#capture" do
    context "when the block accepts no arguments" do
      it "injects the block contents into the head" do
        capture = build_capture do
          "head"
        end

        head, body = capture.capture

        expect(head).to eq("head")
        expect(body).to eq("")
      end
    end

    context "when the block accepts 1 argument" do
      it "can append to the head" do
        capture = build_capture do |head|
          head.append { "head" }
        end

        head, body = capture.capture

        expect(head).to eq("head")
        expect(body).to eq("")
      end
    end

    context "when the block accepts 2 arguments" do
      it "can append to both the head and body" do
        capture = build_capture do |head, body|
          head.append { "head" }
          body.append { "body" }
        end

        head, body = capture.capture

        expect(head).to eq("head")
        expect(body).to eq("body")
      end
    end
  end

  def build_capture(&block)
    HtmlPage::Capture.new(FakeContext.new, &block)
  end

  class FakeContext
    def with_output_buffer(&block)
      block.call
    end
  end
end

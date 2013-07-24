require "spec_helper"

describe GameController do

    let(:controller) {c = GameController.new}

    it "is of type game controller" do
        session[:game].should == nil
    end


end

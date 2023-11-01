require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    let(:student) { create(:student) }

    context "with valid credentials" do
      before do
        post :create, params: { email: student.email, passcode: student.passcode }
      end

      it "sets the session student_id" do
        expect(session[:student_id]).to eq(student.id)
      end

      it "redirects to the root path" do
        expect(response).to redirect_to(root_path)
      end

      it "sets a notice flash message" do
        expect(flash[:notice]).to eq('Logged in successfully')
      end
    end

    context "with invalid credentials" do
      before do
        post :create, params: { email: student.email, passcode: 'invalid_passcode' }
      end

      it "does not set the session student_id" do
        expect(session[:student_id]).to be_nil
      end

      it "renders the new template" do
        expect(response).to render_template(:new)
      end

      it "sets an alert flash message" do
        expect(flash.now[:alert]).to eq('Invalid email or passcode')
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      delete :destroy
    end

    it "resets the session" do
      expect(session).to be_empty
    end

    it "redirects to the root path" do
      expect(response).to redirect_to(root_path)
    end

    it "sets a notice flash message" do
      expect(flash[:notice]).to eq('Logged out successfully')
    end
  end
end
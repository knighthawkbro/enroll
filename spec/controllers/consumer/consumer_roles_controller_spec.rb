require 'rails_helper'

RSpec.describe Consumer::ConsumerRolesController, :type => :controller do
  let(:user){ double("User", email: "test@example.com") }
  let(:person){ double("Person") }
  let(:family){ double("Family") }
  let(:family_member){ double("FamilyMember") }
  let(:consumer_role){ double("ConsumerRole", id: double("id")) }

  context "GET new" do
    before(:each) do
      allow(user).to receive(:build_person).and_return(person)
      allow(controller).to receive(:build_nested_models).and_return(true)
    end
    it "should render new template" do
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  context "POST create" do
    let(:person_params){{"dob"=>"1985-10-01", "first_name"=>"martin","gender"=>"male","last_name"=>"york","middle_name"=>"","name_sfx"=>"","ssn"=>"000000111","user_id"=>"xyz"}}
    let(:user){FactoryGirl.create(:user)}
    before(:each) do
      allow(Factories::EnrollmentFactory).to receive(:construct_employee_role).and_return(consumer_role)
      allow(consumer_role).to receive(:person).and_return(person)
    end
    it "should create new person/consumer role object" do
      sign_in user
      post :create, person: person_params
      expect(response).to have_http_status(:redirect)
    end
  end

  context "GET edit" do
    before(:each) do
      allow(ConsumerRole).to receive(:find).and_return(consumer_role)
      allow(consumer_role).to receive(:person).and_return(person)
      allow(controller).to receive(:build_nested_models).and_return(true)
      allow(user).to receive(:person).and_return(person)
    end
    it "should render new template" do
      sign_in user
      get :edit, id: "test"
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end

  context "PUT update" do
    let(:person_params){{"dob"=>"1985-10-01", "first_name"=>"martin","gender"=>"male","last_name"=>"york","middle_name"=>"","name_sfx"=>"","ssn"=>"468389102","user_id"=>"xyz"}}
    let(:person){ FactoryGirl.build(:person) }

    before(:each) do
      allow(ConsumerRole).to receive(:find).and_return(consumer_role)
      allow(consumer_role).to receive(:person).and_return(person)
      allow(person).to receive(:addresses=).and_return([])
      allow(person).to receive(:phones=).and_return([])
      allow(person).to receive(:emails=).and_return([])
      sign_in user
    end
    it "should update existing person" do
      allow(person).to receive(:update_attributes).and_return(true)
      put :update, person: person_params, id: "test"
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(new_insured_interactive_identity_verification_path)
    end

    it "should not update the person" do
      allow(person).to receive(:update_attributes).and_return(false)
      put :update, person: person_params, id: "test"
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end


end


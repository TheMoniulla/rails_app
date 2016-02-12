require 'rails_helper'

describe UsersController do
  describe '#index' do
    let(:call_request) { get :index }
    let!(:user) { create(:user) }

    context 'after request' do
      before { call_request }
      it { should render_template 'index' }
      it { expect(assigns(:users)).to eq [user] }
    end
  end

  describe '#new' do
    let(:call_request) { get :new }

    context 'after request' do
      before { call_request }

      it { should render_template 'new' }
      it { expect(assigns(:user).persisted?).to be false }
    end
  end

  describe '#edit' do
    let(:call_request) { get :edit, id: user.id }
    let(:user) { create(:user) }

    context 'after request' do
      before { call_request }

      it { should render_template 'edit' }
      it { expect(assigns(:user)).to eq user }
    end
  end

  describe '#show' do
    let(:call_request) { get :show, id: user.id }
    let(:user) { create (:user) }

    context 'after request' do
      before { call_request }

      it { should render_template 'show' }
      it { expect(assigns(:user)).to eq user }
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, id: user.id }
    let!(:user) { create(:user) }

    it { expect { call_request }.to change { User.count }.by(-1) }

    context 'after request' do
      before { call_request }

      it { should redirect_to users_path }
    end
  end

  describe '#create' do
    let(:call_request) { post :create, user: attributes }

    context 'valid request' do
      let(:attributes) { attributes_for(:user, first_name: 'Joe', last_name: 'Doe', email: 'joe@doe.com') }

      it { expect { call_request }.to change { User.count }.by(1) }
      context 'after request' do
        before { call_request }
        let(:user) { User.last }

        it { should redirect_to users_path }
        it { expect(user.first_name).to eq 'Joe' }
        it { expect(user.last_name).to eq 'Doe' }
        it { expect(user.email).to eq 'joe@doe.com' }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:user, first_name: nil, last_name: nil, email: nil) }

      it { expect { call_request }.not_to change { User.count } }

      context 'after request' do
        before { call_request }

        it { should render_template 'new' }
      end
    end
  end

  describe '#update' do
    let(:user) { create(:user, first_name: 'Jane', last_name: 'Joe', email: 'jane@joe.com' ) }
    let(:call_request) { put :update, user: attributes, id: user.id }

    context 'valid request' do
      let(:attributes) { {first_name: 'Joe', last_name: 'Doe', email: 'joe@doe.com'} }

      it { expect { call_request }.to change { user.reload.first_name }.from('Jane').to('Joe') }
      it { expect { call_request }.to change { user.reload.last_name }.from('Joe').to('Doe') }
      it { expect { call_request }.to change { user.reload.email }.from('jane@joe.com').to('joe@doe.com') }

      context 'after request' do
        before { call_request }

        it { should redirect_to users_path }
      end
    end

    context 'invalid request' do
      let(:attributes) { {first_name: 'Jane', last_name: 'Doe', email: nil} }

      it { expect { call_request }.not_to change { user.reload.first_name } }

      context 'after request' do
        before { call_request }

        it { should render_template 'edit' }
      end
    end
  end
end
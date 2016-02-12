require 'rails_helper'

describe ProjectsController do
  describe '#index' do
    let(:call_request) { get :index }
    let!(:project) { create(:project) }

    context 'after request' do
      before { call_request }
      it { should render_template 'index' }
      it { expect(assigns(:active_projects)).to eq [project] }
      it { expect(assigns(:inactive_projects)).to eq [] }
    end
  end

  describe '#new' do
    let(:call_request) { get :new }

    context 'after request' do
      before { call_request }

      it { should render_template 'new' }
      it { expect(assigns(:project).persisted?).to be false }
    end
  end

  describe '#edit' do
    let(:call_request) { get :edit, id: project.id }
    let(:project) { create(:project) }

    context 'after request' do
      before { call_request }

      it { should render_template 'edit' }
      it { expect(assigns(:project)).to eq project }
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, id: project.id }
    let!(:project) { create(:project) }

    it { expect { call_request }.to change { Project.count }.by(-1) }

    context 'after request' do
      before { call_request }

      it { should redirect_to projects_path }
    end
  end

  describe '#create' do
    let(:user) { create(:user) }
    let(:call_request) { post :create, project: attributes }

    context 'valid request' do
      let(:attributes) { attributes_for(:project, name: 'Project No 1', user_id: user.id) }

      it { expect { call_request }.to change { Project.count }.by(1) }
      context 'after request' do
        before { call_request }
        let(:project) { Project.last }

        it { should redirect_to projects_path }
        it { expect(project.active).to eq true }
        it { expect(project.name).to eq 'Project No 1' }
        it { expect(project.user_id).to eq user.id }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:project, name: nil, user_id: user.id) }

      it { expect { call_request }.not_to change { Project.count } }

      context 'after request' do
        before { call_request }

        it { should render_template 'new' }
      end
    end
  end

  describe '#update' do
    let(:user) { create(:user) }
    let(:user_2) { create(:user) }
    let(:project) { create(:project, name: 'Project No 1', active: true, user_id: user.id) }
    let(:call_request) { put :update, project: attributes, id: project.id }

    context 'valid request' do
      let(:attributes) { {name: 'test', active: false, user_id: user_2.id} }

      it { expect { call_request }.to change { project.reload.name }.from('Project No 1').to('test') }
      it { expect { call_request }.to change { project.reload.active }.from(true).to(false) }
      it { expect { call_request }.to change { project.reload.user_id }.from(user.id).to(user_2.id) }

      context 'after request' do
        before { call_request }

        it { should redirect_to projects_path }
      end
    end

    context 'invalid request' do
      let(:attributes) { {name: nil, active: false, user_id: user_2.id} }

      it { expect { call_request }.not_to change { project.reload.name } }

      context 'after request' do
        before { call_request }

        it { should render_template 'edit' }
      end
    end
  end
end
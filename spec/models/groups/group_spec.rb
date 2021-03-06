# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Group::Group do
  context 'associations' do

    it 'can create a group' do
      g = FactoryGirl.build(:group)
    end

    it 'Group has main_group and sub_groups' do
      g = FactoryGirl.create(:group)
      g2 = FactoryGirl.create(:group)
      g3 = FactoryGirl.create(:group)
      g2.main_group = g
      g2.save
      g3.main_group = g
      g3.save

      g2.reload.main_group.should eq(g)
      g3.reload.main_group.should eq(g)
      g.reload.sub_groups.should eq([g2,g3])
    end

    it 'Group and user can send one and many invitations' do
      g = FactoryGirl.create(:group)
      g2 = FactoryGirl.create(:group)
      u = FactoryGirl.create(:user)
      u2 = FactoryGirl.create(:user)


      g.send_invitations([g2,u], 'Venez rejoindre le groupe !')

      u.send_group_invitations(g2, u2)

      g2.reload.received_group_invitations.first.message.should eq('Venez rejoindre le groupe !')
      u.reload.received_group_invitations.first.message.should eq('Venez rejoindre le groupe !')
      u.received_group_invitations.first.group.should eq(g)
      g.reload.group_invitations.count.should eq(2)

      u2.reload.received_group_invitations.first.group.should eq(g2)
      u2.reload.received_group_invitations.first.sender.should eq(u)
    end

    it 'can accept or decline an invitation' do
      g = FactoryGirl.create(:group)
      g2 = FactoryGirl.create(:group)
      u = FactoryGirl.create(:user)
      u2 = FactoryGirl.create(:user)

      g.send_invitations([g2,u], 'Venez rejoindre le groupe !')

      u.received_group_invitations.first.accept
      u.reload.received_group_invitations.first.status.should eq('accepted')
      u.groups.last.should eq(g)
      g2.received_group_invitations.first.chose_later
      g2.received_group_invitations.first.decline
      g.reload.u_members.all.count eq(1)
      g.reload.g_members.all.count eq(0)

      g.members.count eq(1)

      u.group_members.last.joined_method.should eq('was_invited')
      u.group_members.last.role.should eq('member')
    end

  end
end

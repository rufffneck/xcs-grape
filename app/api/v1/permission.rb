module API
	module V1
		class Permission < Grape::API				

			resource 'permissions' do 
				post 'tableadd' do
					params do
						requires :module,type: :string
						requires :act,type: :string
					end
					mod = params[:module]
					act = params[:act]
					name = mod + "." + act
					ss= PermissionTable.create(:name => name)
					ss
				end
				post 'matrixadd' do
					params do
						requires :module,type: :string
						requires :act,type: :string
						requires :role,type: :string
					end
					pername = params[:module] + "." + params[:act]
					
					per_id = PermissionTable.where(:name => pername).pluck(:id)
					roleid = Role.where(:name => params[:role]).pluck(:id)
					if !per_id.nil? && !roleid.nil?
						PermissionMatrix.create(:role_id => roleid[0],:permission_id => per_id[0])
					
					else
						{:error => "enter params"}
					end
					
				end
			end
		end
	end
end
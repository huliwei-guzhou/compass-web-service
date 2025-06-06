# frozen_string_literal: true

module Openapi
  module V2
    module L2
      class SoftwareArtifactPortrait < Grape::API
        version 'v2', using: :path
        prefix :api
        format :json

        helpers Openapi::SharedParams::CustomMetricSearch
        helpers Openapi::SharedParams::AuthHelpers
        helpers Openapi::SharedParams::ErrorHelpers

        rescue_from :all do |e|
          case e
          when Grape::Exceptions::ValidationErrors
            handle_validation_error(e)
          when SearchFlip::ResponseError
            handle_open_search_error(e)
          else
            handle_generic_error(e)
          end
        end

        before { require_token! }
        before do
          token = params[:access_token]
          Openapi::SharedParams::RateLimiter.check_token!(token)
        end

        resource :software_artifact_portrait do

          # 仓库
          desc '仓库文档数量',
               detail: '评估项目文档的数量',
               tags: ['Metrics Data', 'Software Artifact Portrait'],
               success: {
                 code: 201, model: Openapi::Entities::DocNumberResponse
               }
          params {
            use :software_artifact_portrait_search
          }
          post :doc_number do
            fetch_metric_data(metric_name: "doc_number", version_number: params[:version_number])
          end

          desc '仓库文档质量',
               detail: '评估说明文档的数量、质量等支持情况',
               tags: ['Metrics Data', 'Software Artifact Portrait'],
               success: {
                 code: 201, model: Openapi::Entities::DocQuartyResponse
               }
          params {
            use :software_artifact_portrait_search
          }
          post :doc_quarty do
            fetch_metric_data(metric_name: "doc_quarty", version_number: params[:version_number])
          end

          desc '仓库中文文档支持度',
               detail: '评估是否有中文支持。',
               tags: ['Metrics Data', 'Software Artifact Portrait'],
               success: {
                 code: 201, model: Openapi::Entities::ZhFilesNumberResponse
               }
          params {
            use :software_artifact_portrait_search
          }
          post :zh_files_number do
            fetch_metric_data(metric_name: "zh_files_number", version_number: params[:version_number])
          end

          desc '仓库开源许可证兼容性',
               detail: '评估开源项目的开源许可证之间是否兼容。',
               tags: ['Metrics Data', 'Software Artifact Portrait'],
               success: {
                 code: 201, model: Openapi::Entities::LicenseConflictsExistResponse
               }
          params {
            use :software_artifact_portrait_search
          }
          post :license_conflicts_exist do
            fetch_metric_data(metric_name: "license_conflicts_exist", version_number: params[:version_number])
          end

          desc '仓库依赖兼容性',
               detail: '开源软件和依赖软件是否兼容。',
               tags: ['Metrics Data', 'Software Artifact Portrait'],
               success: {
                 code: 201, model: Openapi::Entities::LicenseDepConflictsExistResponse
               }
          params {
            use :software_artifact_portrait_search
          }
          post :license_dep_conflicts_exist do
            fetch_metric_data(metric_name: "license_dep_conflicts_exist", version_number: params[:version_number])
          end

          # 安全
          desc '漏洞响应时间',
               detail: '过去五个版本的漏洞平均响应时间',
               tags: ['Metrics Data', 'Software Artifact Portrait'],
               success: {
                 code: 201, model: Openapi::Entities::VulDetectTimeResponse
               }
          params {
            use :software_artifact_portrait_search
          }
          post :vul_detect_time do
            fetch_metric_data(metric_name: "vul_detect_time", version_number: params[:version_number])
          end

          desc '漏洞反馈信息',
               detail: '是否含有漏洞的反馈方式，以及反馈方式路径。',
               tags: ['Metrics Data', 'Software Artifact Portrait'],
               success: {
                 code: 201, model: Openapi::Entities::VulnerabilityFeedbackChannelsResponse
               }
          params {
            use :software_artifact_portrait_search
          }
          post :vulnerability_feedback_channels do
            fetch_metric_data(metric_name: "vulnerability_feedback_channels", version_number: params[:version_number])
          end

          desc '安全漏洞数',
               detail: '安全漏洞数',
               tags: ['Metrics Data', 'Software Artifact Portrait'],
               success: {
                 code: 201, model: Openapi::Entities::SecurityVulStatResponse
               }
          params {
            use :software_artifact_portrait_search
          }
          post :security_vul_stat do
            fetch_metric_data(metric_name: "security_vul_stat", version_number: params[:version_number])
          end

          desc '安全漏洞等级',
               detail: '评估开源软件的安全漏洞等级。',
               tags: ['Metrics Data', 'Software Artifact Portrait'],
               success: {
                 code: 201, model: Openapi::Entities::VulLevelsResponse
               }
          params {
            use :software_artifact_portrait_search
          }
          post :vul_levels do
            fetch_metric_data(metric_name: "vul_levels", version_number: params[:version_number])
          end

          desc '安全漏洞修复情况',
               detail: '核查已暴露的安全漏洞是否已修复。',
               tags: ['Metrics Data', 'Software Artifact Portrait'],
               success: {
                 code: 201, model: Openapi::Entities::SecurityVulFixedResponse
               }
          params {
            use :software_artifact_portrait_search
          }
          post :security_vul_fixed do
            fetch_metric_data(metric_name: "security_vul_fixed", version_number: params[:version_number])
          end

          # 代码
          desc '代码扫描记录',
               detail: '核查是否有代码扫描记录',
               tags: ['Metrics Data', 'Software Artifact Portrait'],
               success: {
                 code: 201, model: Openapi::Entities::SecurityScannedResponse
               }
          params {
            use :software_artifact_portrait_search
          }
          post :security_scanned do
            fetch_metric_data(metric_name: "security_scanned", version_number: params[:version_number])
          end

          desc '代码可读性',
               detail: '评估代码可读性（模块划分/代码注释等）。',
               tags: ['Metrics Data', 'Software Artifact Portrait'],
               success: {
                 code: 201, model: Openapi::Entities::CodeReadabilityResponse
               }
          params {
            use :software_artifact_portrait_search
          }
          post :code_readability do
            fetch_metric_data(metric_name: "code_readability", version_number: params[:version_number])
          end

        end
      end

    end
  end
end

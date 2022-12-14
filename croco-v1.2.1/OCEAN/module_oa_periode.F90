#include "cppdefs.h"
#ifdef ONLINE_ANALYSIS
!------------------------------------------------------------------------------
!                               NHOMS
!                Non Hydrostatic Ocean Modeling System      
!------------------------------------------------------------------------------
!
!> @note <a href="http://poc.obs-mip.fr/auclair/WOcean.fr/SNH/index_snh_home.htm"> Main web documentation </a>
!
! DESCRIPTION: 
!
!> @brief
!
!> @details 
!
!
! REVISION HISTORY:
!
!> @authors
!> @date 2015 January
!> @todo
!
!------------------------------------------------------------------------------

!************************************************************************
!.....module module_oa_periode
!************************************************************************

      module module_oa_periode

      real ::                                                         & 
           fb_oa                                                      &  !< definition de l''ondelette de morlet complexe
           ,fc_oa                                                        !< par defaut fb_oa=2. et fc_oa=6./3.14159274
                                                                         !< BLXD 2. * pi * fc_oa = 6.
      integer ::                                                      & ! taille de la structure frequentielle du vecteur d etat
           nzvp_oa                                                    &             
          ,nzc_oa                                                       ! nombre de configurations

      integer,dimension(:),allocatable::                              &  ! (nmv_oa)
           swt_wfpf_oa                                                &  ! calcul du coef wf ou du spectre pf (choix utilisateur)
           ,fl_rec_oa                                                    ! flag de reconstruction

      integer,dimension(:),allocatable::                              &  ! (nmv_oa)
           dori_oa                                                       ! configuration frequentielle choisie par l utilisateur

      real,dimension(:),allocatable::                                 &  ! (nmv_oa)
           delta_t_oa                                                    ! nombre de periodes etudiees

      integer,dimension(:),allocatable::                              &  ! (nmvt_oa)
           per_t2p_oa                                                    ! transformation structure temporelle --> structure frequentielle

      real,dimension(:,:),allocatable::                               &  ! (3,nmv_oa)
           per_oa                                                        ! preriodes min, max, delta de chaque variable (ou configuration)

      integer,dimension(:),allocatable::                              &  ! (nmv_oa+1)     
           begvp_oa                                                      ! struture frequentielle du vecteur d etat

      real,dimension(:,:),allocatable::                               &  ! (2,nmvp_oa)
           perv_oa                                                       ! facteurs de reconstruction associes a l'ondelette

      integer,dimension(:,:),allocatable::                            &
         if_last_per_oa                                               &
        ,if_first_per_oa
      integer,dimension(:,:),allocatable::                            &
         lper_fst_oa                                                  &
        ,lper_lst_oa

      integer,dimension(:),allocatable::                              &
         nper_sclg

      real*8,dimension(:),allocatable::                               &  ! (2,nmvp_oa)
           t0, dt0, sq_dt0           
                                                       !
      real,dimension(:),allocatable::                                 &  ! (2,nmvp_oa)
           w0, dw0, sq_dw0

      real,dimension(:),allocatable::                                 &  ! (2,nmvp_oa)
           psi_norm_l2, ft_psi_norm_l2        

      real*8,dimension(:),allocatable::                               &  ! (2,nmvp_oa)
           t0_bis, dt0_bis           
                                                       !
      real,dimension(:),allocatable::                                 &  ! (2,nmvp_oa)
           w0_apx,dw0_apx           

      real,dimension(:),allocatable::                                 &  ! (2,nmvp_oa)
           psi_norm_l2_bis           

      real*8,dimension(:),allocatable::                               &  ! (2,nmvp_oa)
           t0_theo           


      !real*8,dimension(:),allocatable::                               &  ! (2,nmvp_oa)
      !     dt0_theo           
                                                       !
      !real,dimension(:),allocatable::                                 &  ! (2,nmvp_oa)
      !     w0_theo,dw0_theo           

      integer,dimension(:),allocatable::                              &  ! (nmc_oa)
           tc_oa    

! BLXD bug tvc_oa has configuration size
      integer,dimension(:),allocatable::                              &  ! (nmc_oa)
           tvc_oa    

      integer,dimension(:),allocatable::                              &  !  (nmc_oa+1)
           begc_oa    

      integer                                   :: nper_sclg_max
      !integer, parameter                       :: nper_sclg_max_croco = 100

      end module module_oa_periode

#else
      module module_oa_periode_empty
      end module
#endif

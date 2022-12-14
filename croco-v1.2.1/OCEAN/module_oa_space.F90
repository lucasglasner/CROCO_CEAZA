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
!! - Francis Auclair , Jochem Floor and Ivane Pairaud:
!!  - Initial version
!! - Francis Auclair, B. Lemieux-Dudon, C. Nguyen
!!  - Croco-OnlineA module interface, 1st version, Spring 2020
!!  - BLXD tgv_oa, tgv3d_oa variables are moved to the 
!!    module_oa_interface with parametrized array dimension (maxtyp_oa).
!> @date 2015
!> @todo BLXD clean
!
!------------------------------------------------------------------------------

!************************************************************************
!.....module module_oa_space
!************************************************************************

      module module_oa_space

      !use module_interface_oa, only : maxtyp_oa

      real,dimension(:,:),allocatable::                               &  ! (2,nmv_oa)
           lat_oa                                                     &  ! latitude  min, max de la structure 2d du vecteur d etat
           ,lon_oa                                                    &  ! longitude  ...
           ,h_oa                                                      &  ! profondeur ...  
           ,ptij_oa                                                      ! point particulier demande par l utilisateur

      integer,dimension(:,:),allocatable::                            &  ! (2,nmv_oa)
           k_oa                                                          ! niveaux verticaux min et max de la structure 3d du vecteur d etat

      integer,dimension(:),allocatable::                              &  ! (nmv_oa)
           dx_oa                                                      &  ! resolution horizontale suivant x demandee par l utilisateur
           ,dy_oa                                                     &  ! resolution horizontale suivant y demandee par l utilisateur
           ,dk_oa                                                        ! resolution verticale   suivant z demandee par l utilisateur

      !! #BLXD variables moved to the module_oa_interface module with parametrized dimension set to maxtyp_oa 
      !integer,dimension(maxtyp_oa)::                                  &  ! changed 100 to 200 jwf 20070619
      !     tgv3d_oa                                                   &  !
      !     ,tgv_oa                                                       ! type de point de la grille c auquel est associee la variable symphonie
      !
      !character(len=5),dimension(maxtyp_oa) :: tgvnam_oa

      end module module_oa_space

#else
      module module_oa_space_empty
      end module
#endif

